//
//  CurrencyModel.swift
//  XChange
//
//  Created by Aldo Vernando on 05/10/23.
//

/**
 This file defines the `CurrencyModel` structure, representing a currency with its code, name, and exchange rate. This documentation provides an overview of the `CurrencyModel` structure.
 */

import Foundation

/**
 A structure representing a currency with its code, name, and exchange rate.
 */
struct CurrencyModel{
    // The unique code representing the currency (e.g., JPY, EUR).
    let code: String
    
    /// The name or description of the currency (e.g., Japanese Yen, Euro).
    let name: String
    
    /// The exchange rate of the currency relative to another currency.
    let rate: Double
    
    /**
     Initializes a `CurrencyModel` with the specified code, name, and exchange rate.
     
     - Parameters:
     - code: The unique code representing the currency (e.g., JPY, EUR).
     - name: The name or description of the currency (e.g., Japanese Yen, Euro).
     - rate: The exchange rate of the currency relative to another currency.
     */
    init(code: String, name: String, rate: Double) {
        self.code = code
        self.name = name
        self.rate = rate
    }
}
