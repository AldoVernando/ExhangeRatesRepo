//
//  NetworkEndpoint.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 NetworkEndpoint.swift
 
 This file defines a protocol `NetworkEndpoint` that serves as a blueprint for creating network service endpoints. It encapsulates properties and methods related to network requests, such as the base URL, request body parameters, endpoint path, headers, HTTP method, and query parameters.
 */

import Foundation

/**
 NetworkEndpoint

**How to use**
 ```
 enum ServiceEndpoint: NetworkEndpoint {
     case getCurrencies
     
     var baseUrl: String {
         return "https://openexchangerates.org"
     }
 
     var bodyParams: [String: Any]? {
         return [:]
     }
 
     var endpoint: String {
         return "/api/currencies.json"
     }
 
     var headers: [String: String] {
         return ["Accept": "application/json"]
     }
 
     var method: String {
         return "GET"
     }
 
     var queryParams: [String: Any] {
         return [:]
     }
 }
 ```
 
 You can then use this `ServiceEndpoint` enumeration to construct network requests with the specified properties.
 */

/**
 The `NetworkEndpoint` protocol defines the structure of a network service endpoint.
 */
protocol NetworkEndpoint {
    var baseUrl: String { get }
    var bodyParams: [String: Any]? { get }
    var endpoint: String { get }
    var headers: [String: String] { get }
    var httpMethod: String { get }
    var queryParams: [String: Any] { get }
}


/**
 Default implementations for optional variables in the `NetworkEndpoint` protocol.
 */
extension NetworkEndpoint {
    var bodyParams: [String: Any]? { return nil }
    var headers: [String: String] { return [:] }
    var queryParams: [String: Any] { return [:] }
}
