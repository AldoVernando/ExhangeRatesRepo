//
//  MockExchangeRateService.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import Foundation

@testable import XChange

// Mock implementation of ExchangeRateServiceProtocol
final class MockExchangeRateService: ExchangeRateServiceProtocol {
    // Define mock data to simulate network responses
    let mockData: [CurrencyRateModel] = [
        .init(code: "USD", name: "United States Dollar", rate: 1.0),
        .init(code: "JPY", name: "Japanese Yen", rate: 2.0)
    ]
    
    func fetchCurrencyRate() async throws -> [CurrencyRateModel]? {
        return mockData
    }
}
