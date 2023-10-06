//
//  ExchangeRateEndpoint.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

/**
 This file defines the `ExchangeRateEndpoint` enumeration, which enumerates the various endpoints for making network requests related to exchange rate data, currency information, and usage details. Each case represents a specific endpoint and conforms to the `NetworkEndpoint` protocol. This documentation provides an overview of the `ExchangeRateEndpoint` enumeration and its cases.
 */

import Foundation

/**
 An enumeration representing different endpoints for exchange rate-related network requests.
 */
enum ExchangeRateEndpoint: NetworkEndpoint {
    /// Represents the endpoint for fetching the latest exchange rates.
    case latest
    
    /// Represents the endpoint for fetching historical exchange rates for a specific date.
    case history(_ date: String)
    
    /// Represents the endpoint for fetching a dictionary of currency codes and names.
    case currencies
    
    /// Represents the endpoint for fetching usage details.
    case usage
    
    /**
     The base URL for the exchange rate API, obtained from the app's Info.plist file.
     
     - Returns: The base URL as a string.
     */
    var baseUrl: String {
        return Bundle.main.object(forInfoDictionaryKey: Constant.BASE_URL) as? String ?? ""
    }
    
    /**
     The specific endpoint path for the case.
     
     - Returns: The endpoint path as a string.
     */
    var endpoint: String {
        switch self {
        case .latest:
            return "/latest.json"
        case .history(let date):
            return "/historical/\(date).json"
        case .currencies:
            return "/currencies.json"
        case .usage:
            return "/usage.json"
        }
    }
    
    /**
     The HTTP headers required for the endpoint, including authorization.
     
     - Returns: A dictionary of HTTP headers.
     */
    var headers: [String : String] {
        let appId: String = Bundle.main.object(forInfoDictionaryKey: Constant.APP_ID) as? String ?? ""
        return [
            Constant.AUTHORIZATION: "Token \(appId)"
        ]
    }
    
    /**
     The HTTP request method for the endpoint.
     
     - Returns: The HTTP request method as a string (e.g., "GET", "POST").
     */
    var httpMethod: String {
        return "GET"
    }
}
