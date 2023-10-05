//
//  NetworkManager.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 NetworkManager.swift
 
 This file defines the `NetworkManager` class, which is responsible for making network requests using URLSession and handling the associated errors. It conforms to the `NetworkManagerProtocol` and provides documentation for its public methods and extensions.
 */

import Foundation

/**
 A protocol that defines the structure of a network manager for making asynchronous network requests.
 */
protocol NetworkManagerProtocol {
    /**
     Performs a network request and returns the decoded response model.
     
     - Parameters:
     - data: The network endpoint data required for the service.
     
     - Returns: A decoded response model or a network error.
     */
    func request<T: Decodable>(endpoint data: NetworkEndpoint) async throws -> T
}

/**
 A class responsible for making network requests using URLSession and handling associated errors.
 */
final class NetworkManager: NetworkManagerProtocol {
    private var session: URLSession
    private let decoder: JSONDecoder
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        decoder = .init()
    }
    
    /**
     Handles a network URL request.
     
     - Parameters:
     - endpoint: The network endpoint data required for the service.
     
     - Returns: A decoded response model or a network error.
     */
    func request<T: Decodable>(endpoint data: NetworkEndpoint) async throws -> T {
        guard let urlRequest: URLRequest = constructUrlRequest(data) else {
            print("[Log] Failed while constructing url.")
            throw NetworkError.badRequest(description: "[Bad Request] Failed while constructing url.")
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            try await handleNetworkErrorResponse(data, response: response)
            
            return try decoder.decode(T.self, from: data)
        } catch {
            print("[Log] Throw error while requesting url.")
            print("[Error] \(error.localizedDescription)")
            
            if let networkError = error as? NetworkError {
                throw networkError
            }
            throw NetworkError.unknown
        }
    }
}


//MARK: - Handler
extension NetworkManager {
    /**
     Handles network error responses.
     
     - Parameters:
     - data: The error response data.
     - response: The URL response.
     
     - Throws: A network error.
     */
    private func handleNetworkErrorResponse(_ data: Data, response: URLResponse) async throws {
        guard let httpResponse = response as? HTTPURLResponse,
              !(200..<300).contains(httpResponse.statusCode)
        else { return }
        
        do {
            let errorResponse: GeneralErrorModel = try decoder.decode(GeneralErrorModel.self, from: data)
            
            throw NetworkError(
                statusCode: errorResponse.status ?? httpResponse.statusCode,
                errorDescription: errorResponse.description
            )
        } catch {
            print("[Log] Throw error while decoding general error model.")
            print("[Error] \(error.localizedDescription)")
            throw NetworkError.unknown
        }
    }
}


//MARK: - Helper
extension NetworkManager {
    /**
     Constructs a URLRequest based on the provided network endpoint data.
     
     - Parameters:
     - data: The network endpoint data required for the service.
     
     - Returns: An optional URLRequest.
     */
    private func constructUrlRequest(_ data: NetworkEndpoint) -> URLRequest? {
        let url: String = data.baseUrl + "?" + generateQueryParams(data.queryParams)
        guard let serviceUrl: URL = .init(string: url) else { return nil }
        
        var request: URLRequest = .init(url: serviceUrl)
        request.httpMethod = data.httpMethod
        
        data.headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        if let bodyParams: [String: Any] = data.bodyParams,
           let httpBody: Data = try? JSONSerialization.data(withJSONObject: bodyParams, options: []) {
            request.httpBody = httpBody
        }
        return request
    }
    
    /**
     Generates query parameters as a string.
     
     - Parameters:
     - params: The query parameters dictionary.
     
     - Returns: A string representation of query parameters.
     */
    private func generateQueryParams(_ params: [String: Any]) -> String {
        let paramStrings: [String] = params.map({ (key, value) -> String in
            return "\(key)=\(value)"
        })
        return paramStrings.joined(separator: "&")
    }
}
