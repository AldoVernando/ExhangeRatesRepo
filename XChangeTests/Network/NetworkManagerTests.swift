//
//  NetworkManagerTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManager!
    
    override func setUpWithError() throws {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        
        let urlSession: URLSession = .init(configuration: configuration)
        
        self.networkManager = .init(session: urlSession)
    }
    
    override func tearDownWithError() throws {
        networkManager = nil
    }
    
    func testRequestSuccess() async {
        let mockJSONData: Data = """
            {"message": "Test response data"}
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), mockJSONData, nil)
        }
        let expectation = XCTestExpectation(description: "response")
        
        do {
            let response: TestResponseModel = try await networkManager.request(endpoint: TestNetworkEndpoint.dashboard)
            
            XCTAssertEqual(response.message, "Test response data")
            expectation.fulfill()
        } catch {
            XCTFail("Unexpected error: \(error)")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func testRequestFailure() async {
        let mockError: NetworkError = .underMaintenance(description: "Server under maintenance")
        
        MockURLProtocol.requestHandler = { _ in
            return (HTTPURLResponse(), nil, mockError)
        }
        let expectation = XCTestExpectation(description: "response")
        
        do {
            _ = try await networkManager.request(endpoint: TestNetworkEndpoint.dashboard) as TestResponseModel
            XCTFail("Expected error was not thrown")
            expectation.fulfill()
        } catch {
            XCTAssertTrue(error is NetworkError)
            XCTAssertEqual("Server under maintenance", mockError.message)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
}
