//
//  MockNetworkManager.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import Foundation

@testable import XChange

// Mock implementations of NetworkManagerProtocol and CurrencyPersistenceManagerProtocol
final class MockNetworkManager: NetworkManagerProtocol {
    
    // Define mock data to simulate network responses
    let mockLatestData: Data = """
            {
                "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
                "license": "https://openexchangerates.org/license",
                "timestamp": 1696687214,
                "base": "USD",
                "rates": {
                    "AED": 3.67303,
                    "AFN": 75.800865
                }
            }
            """.data(using: .utf8)!
    
    let mockCurrenciesData: Data = """
            {
                "AED": "United Arab Emirates Dirham",
                "AFN": "Afghan Afghani"
            }
            """.data(using: .utf8)!
    
    
    
    func request<T: Decodable>(endpoint data: NetworkEndpoint) async throws -> T {
        // Implement a mock network request and return mock data
        if data.endpoint == ExchangeRateEndpoint.currencies.endpoint {
            return try JSONDecoder().decode(T.self, from: mockCurrenciesData)
        }
        return try JSONDecoder().decode(T.self, from: mockLatestData)
    }
}
