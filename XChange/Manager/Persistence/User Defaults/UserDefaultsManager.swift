//
//  UserDefaultsManager.swift
//  XChange
//
//  Created by Aldo Vernando on 05/10/23.
//

/**
 This file defines the `UserDefaultsManager` class, which provides convenience methods for managing user defaults in your application. This documentation outlines the purpose of the class and its methods.
 */

import Foundation

/**
 A class for managing user defaults in your application.
 */
final class UserDefaultsManager {
    /// The shared instance of UserDefaults, which provides access to user defaults storage.
    static let defaults: UserDefaults = .standard
    
    /**
     Sets the value for a specific user defaults key.
     
     - Parameters:
     - key: The user defaults key to set the value for.
     - value: The value to set for the specified key.
     */
    static func setValue(forKey key: UserDefaultsKey, value: Any) {
        defaults.set(value, forKey: key.value)
    }
    
    /**
     Retrieves the value associated with a specific user defaults key.
     
     - Parameters:
     - key: The user defaults key to retrieve the value for.
     
     - Returns: The value associated with the specified key, or nil if no value is found.
     */
    static func getValue(forKey key: UserDefaultsKey) -> Any? {
        return defaults.object(forKey: key.value)
    }
    
    /**
     Removes the value associated with a specific user defaults key.
     
     - Parameters:
     - key: The user defaults key to remove the value for.
     */
    static func removeValue(forKey key: UserDefaultsKey) {
        defaults.removeObject(forKey: key.value)
    }
}
