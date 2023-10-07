//
//  CurrencyValueModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `CurrencyValueModel` struct, which represents a currency with its code, name, and value. This documentation provides an overview of the struct and its properties.
*/

import Foundation

struct CurrencyValueModel {
    /// The currency code, e.g., "USD", "JPY"
    var code: String
    
    /// The currency name, e.g., "United States Dollar", "Japanese Yen"
    var name: String
    
    /// The currency value.
    var value: Double
    
    /**
     Initializes a `CurrencyValueModel` with the specified properties.

     - Parameters:
        - code: The currency code, e.g., "USD", "JPY"
        - name: The currency name, e.g., "United States Dollar", "Japanese Yen"
        - value: The currency value.
     */
    init(
        code: String,
        name: String,
        value: Double
    ) {
        self.code = code
        self.name = name
        self.value = value
    }
}
