//
//  UserDefaultsKey.swift
//  XChange
//
//  Created by Aldo Vernando on 05/10/23.
//

/**
 This file defines the `UserDefaultsKey` protocol and an enumeration `CacheKey` that conforms to the protocol. These are used for defining keys to access values stored in user defaults. This documentation provides an overview of their purpose and usage.
 */

import Foundation

/**
 A protocol that defines the structure of a user defaults key for accessing stored values.
 */
protocol UserDefaultsKey {
    /// The string value associated with the user defaults key.
    var value: String { get }
}

/**
 An enumeration that provides predefined user defaults keys for accessing stored values.
 */
enum CacheKey: String, UserDefaultsKey {
    /// A user defaults key for accessing the latest API request timestamp.
    case LATEST_API_REQUEST_TIMESTAMP
    
    /**
     The string value associated with the user defaults key.
     */
    var value: String {
        self.rawValue
    }
}
