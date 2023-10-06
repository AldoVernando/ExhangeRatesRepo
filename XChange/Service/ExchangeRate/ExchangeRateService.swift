//
//  ExchangeRateService.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

/**
 This file defines the `ExchangeRateService` class, which conforms to the `ExchangeRateServiceProtocol`. The class is responsible for making asynchronous network requests to fetch exchange rate data, currency information, and usage details. This documentation provides an overview of the `ExchangeRateService` class and its methods.
 */

import Foundation

/**
 A protocol defining the structure of a service for fetching exchange rate data, currency information, and usage details.
 */
protocol ExchangeRateServiceProtocol {
    /**
     Fetches the latest exchange rates asynchronously.
     
     - Returns: A `RatesResponseModel` containing the latest exchange rate data.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchLatestRates() async throws -> RatesResponseModel
    
    /**
     Fetches historical exchange rates for a specific date asynchronously.
     
     - Parameters:
     - date: The date for which historical exchange rates are requested in the format "yyyy-MM-dd".
     
     - Returns: A `RatesResponseModel` containing historical exchange rate data for the specified date.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchRatesHistory(at date: String) async throws -> RatesResponseModel
    
    /**
     Fetches a dictionary of currency codes and names asynchronously.
     
     - Returns: A dictionary where keys are currency codes and values are currency names.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchCurrencies() async throws -> [String: String]
    
    /**
     Fetches usage details asynchronously.
     
     - Returns: A `UsageResponseModel` containing usage information.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchUsage() async throws -> UsageResponseModel
}

/**
 A class that implements the `ExchangeRateServiceProtocol` for fetching exchange rate data, currency information, and usage details.
 */
final class ExchangeRateService: ExchangeRateServiceProtocol {
    private let network: NetworkManagerProtocol
    
    /**
     Initializes an instance of `ExchangeRateService`.
     
     - Parameter network: An instance conforming to the `NetworkManagerProtocol` for making network requests.
     */
    init(network: NetworkManagerProtocol) {
        self.network = network
    }
    
    /**
     Fetches the latest exchange rates asynchronously.
     
     - Returns: A `RatesResponseModel` containing the latest exchange rate data.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchLatestRates() async throws -> RatesResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.latest)
    }
    
    /**
     Fetches historical exchange rates for a specific date asynchronously.
     
     - Parameters:
     - date: The date for which historical exchange rates are requested in the format "yyyy-MM-dd".
     
     - Returns: A `RatesResponseModel` containing historical exchange rate data for the specified date.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchRatesHistory(at date: String) async throws -> RatesResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.history(date))
    }
    
    /**
     Fetches a dictionary of currency codes and names asynchronously.
     
     - Returns: A dictionary where keys are currency codes and values are currency names.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchCurrencies() async throws -> [String: String] {
        return try await network.request(endpoint: ExchangeRateEndpoint.currencies)
    }
    
    /**
     Fetches usage details asynchronously.
     
     - Returns: A `UsageResponseModel` containing usage information.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchUsage() async throws -> UsageResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.usage)
    }
}
