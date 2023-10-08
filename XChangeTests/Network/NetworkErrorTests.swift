//
//  NetworkErrorTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class NetworkErrorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // Test initialization of various network errors
    func testNetworkErrorInitialization() {
        let badRequest = NetworkError(statusCode: 400, errorDescription: "Bad request description")
        XCTAssertEqual(badRequest, .badRequest(description: "Bad request description"))
        
        let unauthorized = NetworkError(statusCode: 401, errorDescription: "Unauthorized description")
        XCTAssertEqual(unauthorized, .unauthorized(description: "Unauthorized description"))
        
        let forbidden = NetworkError(statusCode: 403, errorDescription: "Forbidden description")
        XCTAssertEqual(forbidden, .forbidden(description: "Forbidden description"))
        
        let notFound = NetworkError(statusCode: 404, errorDescription: "Not found description")
        XCTAssertEqual(notFound, .notFound(description: "Not found description"))
        
        let serverError = NetworkError(statusCode: 500, errorDescription: "Server error description")
        XCTAssertEqual(serverError, .serverError(description: "Server error description"))
        
        let underMaintenance = NetworkError(statusCode: 503, errorDescription: "Under maintenance description")
        XCTAssertEqual(underMaintenance, .underMaintenance(description: "Under maintenance description"))
        
        let unknown = NetworkError(statusCode: 999, errorDescription: "Unknown error description")
        XCTAssertEqual(unknown, .unknown)
    }
    
    // Test computed properties of network errors
    func testNetworkErrorComputedProperties() {
        let badRequest = NetworkError.badRequest(description: "Bad request description")
        XCTAssertEqual(badRequest.statusCode, 400)
        XCTAssertEqual(badRequest.message, "Bad request description")
        
        let unauthorized = NetworkError.unauthorized(description: "Unauthorized description")
        XCTAssertEqual(unauthorized.statusCode, 401)
        XCTAssertEqual(unauthorized.message, "Unauthorized description")
        
        let forbidden = NetworkError.forbidden(description: "Forbidden description")
        XCTAssertEqual(forbidden.statusCode, 403)
        XCTAssertEqual(forbidden.message, "Forbidden description")
        
        let notFound = NetworkError.notFound(description: "Not found description")
        XCTAssertEqual(notFound.statusCode, 404)
        XCTAssertEqual(notFound.message, "Not found description")
        
        let serverError = NetworkError.serverError(description: "Server error description")
        XCTAssertEqual(serverError.statusCode, 500)
        XCTAssertEqual(serverError.message, "Server error description")
        
        let underMaintenance = NetworkError.underMaintenance(description: "Under maintenance description")
        XCTAssertEqual(underMaintenance.statusCode, 503)
        XCTAssertEqual(underMaintenance.message, "Under maintenance description")
        
        let unknown = NetworkError.unknown
        XCTAssertEqual(unknown.statusCode, 520)
        XCTAssertEqual(unknown.message, "[Unknown] Network error cannot be define.")
    }
}
