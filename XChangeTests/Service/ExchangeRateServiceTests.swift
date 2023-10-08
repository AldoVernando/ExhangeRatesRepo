//
//  ExchangeRateServiceTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class ExchangeRateServiceTests: XCTestCase {
    // Create instances of the mock classes
    let mockNetworkManager: MockNetworkManager = .init()
    let mockCurrencyPersistenceManager: MockCurrencyPersistenceManager = .init()
    
    // Initialize ExchangeRateService with mock dependencies
    var exchangeRateService: ExchangeRateService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Initialize ExchangeRateService with mock dependencies
        exchangeRateService = ExchangeRateService(network: mockNetworkManager, storage: mockCurrencyPersistenceManager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        // Reset currencies data after each test
        mockCurrencyPersistenceManager.currencies = []
    }
    
    // Test fetching currency rate data
    func testFetchCurrencyRate() async {
        do {
            // Simulate a successful network request
            let currencyRateModels: [CurrencyRateModel]? = try await exchangeRateService.fetchCurrencyRate()
            
            // Check if the data was fetched
            XCTAssertNotNil(currencyRateModels)
            XCTAssertEqual(currencyRateModels?.count, 2)
        } catch {
            XCTFail("Error occurred while fetching currency rate: \(error.localizedDescription)")
        }
    }
}
