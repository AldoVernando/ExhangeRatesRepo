//
//  NetworkEndpointTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class NetworkEndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test a basic GET request
    func testNetworkEndpointGetRequest() {
        let endpoint: TestNetworkEndpoint = .dashboard
        
        XCTAssertEqual(endpoint.baseUrl, "https://example.com")
        XCTAssertEqual(endpoint.endpoint, "/dashboard")
        XCTAssertEqual(endpoint.httpMethod, "GET")
        XCTAssertNil(endpoint.bodyParams)
    }
    
    // Test a POST request with JSON body
    func testNetworkEndpointPostRequest() {
        let endpoint: TestNetworkEndpoint = .submitData
        
        XCTAssertEqual(endpoint.baseUrl, "https://example.com")
        XCTAssertEqual(endpoint.endpoint, "/submit/data")
        XCTAssertEqual(endpoint.httpMethod, "POST")
        XCTAssertEqual(endpoint.headers, ["Content-Type": "application/json"])
        XCTAssertNotNil(endpoint.bodyParams)
        
        if let bodyParams = endpoint.bodyParams {
            XCTAssertEqual(bodyParams as? [String: Int], ["id": 123])
        } else {
            XCTFail("bodyParams should not be nil for a POST request")
        }
    }
}
