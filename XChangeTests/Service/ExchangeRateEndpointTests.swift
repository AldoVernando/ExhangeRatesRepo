//
//  ExchangeRateEndpointTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class ExchangeRateEndpointTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // Test the base URL
    func testBaseURL() {
        XCTAssertEqual(ExchangeRateEndpoint.latest.baseUrl, "https://openexchangerates.org/api")
        XCTAssertEqual(ExchangeRateEndpoint.history("2023-10-06").baseUrl, "https://openexchangerates.org/api")
        XCTAssertEqual(ExchangeRateEndpoint.currencies.baseUrl, "https://openexchangerates.org/api")
        XCTAssertEqual(ExchangeRateEndpoint.usage.baseUrl, "https://openexchangerates.org/api")
    }
    
    // Test the endpoint paths
    func testEndpointPaths() {
        XCTAssertEqual(ExchangeRateEndpoint.latest.endpoint, "/latest.json")
        XCTAssertEqual(ExchangeRateEndpoint.history("2023-10-06").endpoint, "/historical/2023-10-06.json")
        XCTAssertEqual(ExchangeRateEndpoint.currencies.endpoint, "/currencies.json")
        XCTAssertEqual(ExchangeRateEndpoint.usage.endpoint, "/usage.json")
    }
    
    // Test the HTTP headers
    func testHeaders() {
        let appId: String = Bundle.main.object(forInfoDictionaryKey: Constant.APP_ID) as? String ?? ""
        
        XCTAssertEqual(ExchangeRateEndpoint.latest.headers[Constant.AUTHORIZATION], "Token \(appId)")
        XCTAssertEqual(ExchangeRateEndpoint.history("2023-10-06").headers[Constant.AUTHORIZATION], "Token \(appId)")
        XCTAssertEqual(ExchangeRateEndpoint.currencies.headers[Constant.AUTHORIZATION], "Token \(appId)")
        XCTAssertEqual(ExchangeRateEndpoint.usage.headers[Constant.AUTHORIZATION], "Token \(appId)")
    }
    
    // Test the HTTP request methods
    func testHTTPMethods() {
        XCTAssertEqual(ExchangeRateEndpoint.latest.httpMethod, "GET")
        XCTAssertEqual(ExchangeRateEndpoint.history("2023-10-06").httpMethod, "GET")
        XCTAssertEqual(ExchangeRateEndpoint.currencies.httpMethod, "GET")
        XCTAssertEqual(ExchangeRateEndpoint.usage.httpMethod, "GET")
    }
}
