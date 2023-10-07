//
//  CurrencyValueModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `CurrencyValueModel` struct, which represents a currency with its code, name, value, and rate. This documentation provides an overview of the struct and its properties.
*/

import Foundation

struct CurrencyValueModel {
    /// The currency code, e.g., "USD", "JPY"
    var code: String
    
    /// The currency name, e.g., "United States Dollar", "Japanese Yen"
    var name: String
    
    /// The currency value.
    var value: Double
    
    /// The currency rate.
    var rate: Double
    
    /**
     Initializes a `CurrencyValueModel` with the specified properties.

     - Parameters:
        - code: The currency code, e.g., "USD", "JPY"
        - name: The currency name, e.g., "United States Dollar", "Japanese Yen"
        - value: The currency value.
        - rate: The currency rate.
     */
    init(
        code: String,
        name: String,
        value: Double,
        rate: Double
    ) {
        self.code = code
        self.name = name
        self.value = value
        self.rate = rate
    }
}
