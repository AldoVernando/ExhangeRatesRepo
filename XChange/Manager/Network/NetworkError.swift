//
//  NetworkError.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 NetworkError.swift
 
 This file defines a custom error enumeration `NetworkError` that conforms to the `NetworkErrorProtocol`. It provides a structured way to handle network-related errors, such as HTTP status code errors, and maps them to meaningful error types. It also includes error messages to describe the nature of the error.
 */

import Foundation

/**
 A protocol that defines the common properties for network errors.
 */
protocol NetworkErrorProtocol: Error {
    /// A descriptive message for the error.
    var message: String { get }
    /// The HTTP status code associated with the error.
    var statusCode: Int { get }
}

/**
 An enumeration representing various network-related errors.
 */
enum NetworkError: NetworkErrorProtocol {
    // Possible error cases
    
    case badRequest(description: String?)
    case forbidden(description: String?)
    case notFound(description: String?)
    case serverError(description: String?)
    case unauthorized(description: String?)
    case underMaintenance(description: String?)
    case unknown
    
    /**
     Initializes a `NetworkError` based on the provided HTTP status code and error description.
     
     - Parameters:
     - statusCode: The HTTP status code associated with the error.
     - errorDescription: A descriptive message for the error.
     */
    init(
        statusCode: Int,
        errorDescription: String?
    ) {
        switch statusCode {
        case 400: // Bad Request
            self = .badRequest(description: errorDescription)
        
        case 401: // Unauthorized
            self = .unauthorized(description: errorDescription)
            
        case 403: // Forbidden
            self = .forbidden(description: errorDescription)
            
        case 404: // Not Found
            self = .notFound(description: errorDescription)
                        
        case 500: // Internal Server Error
            self = .serverError(description: errorDescription)
            
        case 503: // Service Unavailable
            self = .underMaintenance(description: errorDescription)
            
        default:
            self = .unknown
        }
    }
    
    /// The computed property that returns the HTTP status code associated with the error.
    var statusCode: Int {
        switch self {
        case .badRequest:
            return 400
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .serverError:
            return 500
        case .unauthorized:
            return 401
        case .underMaintenance:
            return 503
        default:
            return 520
        }
    }
    
    /// The computed property that returns a descriptive message for the error.
    var message: String {
        switch self {
        case .badRequest(let description):
            return description ?? "[Bad Request] Please check your url request."
        case .forbidden(let description):
            return description ?? "[No Permission] Please check your permission."
        case .notFound(let description):
            return description ?? "[Not Found] The url you looking for not found."
        case .serverError(let description):
            return description ?? "[Server Error] Server is currently not available."
        case .unauthorized(let description):
            return description ?? "[Unauthorized] Please check your credentials."
        case .underMaintenance(let description):
            return description ?? "[Under Maintenance] Please get back later."
        case .unknown:
            return "[Unknown] Network error cannot be define."
        }
    }
}
