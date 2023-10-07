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
 A protocol defining the structure of a service for fetching currency rate.
 */
protocol ExchangeRateServiceProtocol {
    func fetchCurrencyRate() async throws -> [CurrencyRateModel]?
}

/**
 A class that implements the `ExchangeRateServiceProtocol` for fetching currency rate.
 */
final class ExchangeRateService: ExchangeRateServiceProtocol {
    private let network: NetworkManagerProtocol
    private let storage: CurrencyPersistenceManagerProtocol
    
    /**
     Initializes an instance of `ExchangeRateService`.
     
     - Parameters:
         - network: An instance conforming to the `NetworkManagerProtocol` for making network requests.
         - storage : An instance conforming to the `CurrencyPersistenceManagerProtocol` for managing currency data.
     */
    init(
        network: NetworkManagerProtocol,
        storage: CurrencyPersistenceManagerProtocol
    ) {
        self.network = network
        self.storage = storage
    }
    
    /**
     Fetches currency rate data asynchronously and caches it.
     
     - Returns: An array of `CurrencyRateModel` representing the currency rates or `nil` if the data is not available.
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    func fetchCurrencyRate() async throws -> [CurrencyRateModel]? {
        if isCacheDataValid(for: CacheKey.LATEST_CURRENCY_RATE_REQUEST_TIMESTAMP),
           let cachedData: [CurrencyRateModel] = storage.retrieve(), !cachedData.isEmpty
        {
            return cachedData
        }
        
        do {
            let latestRates: RatesResponseModel = try await fetchLatestRates()
            let currencies: [String: String] = try await fetchCurrencies()
            
            let result: [CurrencyRateModel]? = latestRates.rates?.compactMap { (code: String, value: Double) in
                let model: CurrencyRateModel = .init(
                    code: code,
                    name: currencies[code] ?? "-",
                    rate: value
                )
                
                if storage.isDataExists(data: model) {
                    storage.update(data: model)
                } else {
                    storage.create(data: model)
                }
                UserDefaultsManager.setValue(forKey: CacheKey.LATEST_CURRENCY_RATE_REQUEST_TIMESTAMP, value: Date())
                return model
            }
            
            return result
        } catch {
            print("[Log] Throw error while fetching and mapping currency rate model.")
            print("[Error] \(error.localizedDescription)")
            
            throw error
        }
    }
}


extension ExchangeRateService {
    /**
     Fetches the latest exchange rates asynchronously.
     
     - Returns: A `RatesResponseModel` containing the latest exchange rate data.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    private func fetchLatestRates() async throws -> RatesResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.latest)
    }
    
    /**
     Fetches historical exchange rates for a specific date asynchronously.
     
     - Parameters:
     - date: The date for which historical exchange rates are requested in the format "yyyy-MM-dd".
     
     - Returns: A `RatesResponseModel` containing historical exchange rate data for the specified date.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    private func fetchRatesHistory(at date: String) async throws -> RatesResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.history(date))
    }
    
    /**
     Fetches a dictionary of currency codes and names asynchronously.
     
     - Returns: A dictionary where keys are currency codes and values are currency names.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    private func fetchCurrencies() async throws -> [String: String] {
        return try await network.request(endpoint: ExchangeRateEndpoint.currencies)
    }
    
    /**
     Fetches usage details asynchronously.
     
     - Returns: A `UsageResponseModel` containing usage information.
     
     - Throws: A `NetworkError` if the network request fails or if there's an issue with the response.
     */
    private func fetchUsage() async throws -> UsageResponseModel {
        return try await network.request(endpoint: ExchangeRateEndpoint.usage)
    }
}


extension ExchangeRateService {
    
    /**
     Checks if the cached data is still valid based on a specified time interval.
     
     - Parameter key: A `UserDefaultsKey` representing the key used to store the cache timestamp.
     - Returns: A boolean value indicating whether the cached data is still valid (true) or outdated (false).
     */
    private func isCacheDataValid(for key: UserDefaultsKey) -> Bool {
        guard let latestTimestamp: Date = UserDefaultsManager.getValue(forKey: key) as? Date,
              let minuteDiff: Int = latestTimestamp.timeDiff(for: Date()).minute
        else {
            return false
        }
        return minuteDiff < Constant.CACHE_TIME_OUT
    }
}
