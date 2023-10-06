//
//  Constant.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

/**
 This file defines a set of constants used in the XChange application. These constants are used for various purposes, such as service configuration, authorization, and base URL for network requests. This documentation provides an overview of the constants defined in this file.
 */

import Foundation

/**
 A struct containing constants used in the XChange application.
 */
struct Constant {
    // MARK: - Services
    
    /// The key for accessing the application ID in the app's Info.plist file.
    static let APP_ID = "APP_ID"
    
    /// The key for the "Authorization" header in HTTP requests.
    static let AUTHORIZATION = "Authorization"
    
    /// The key for accessing the base URL for exchange rate-related network requests in the app's Info.plist file.
    static let BASE_URL = "EXCHANGE_RATE_BASE_URL"
}
