//
//  RatesResponseModel.swift
//  XChange
//
//  Created by Aldo Vernando on 06/10/23.
//

/**
 This file defines the `RatesResponseModel` structure, which is used for decoding response data from exchange rate API calls. The structure conforms to the `Decodable` protocol, making it suitable for parsing JSON responses. This documentation provides an overview of the `RatesResponseModel` and its properties.
 */

import Foundation

struct RatesResponseModel: Decodable {
    /// A disclaimer statement related to the exchange rate data.
    var disclaimer: String?
    
    /// The license information associated with the exchange rate data.
    var license: String?
    
    /// A timestamp indicating when the exchange rate data was last updated.
    var timestamp: Double?
    
    /// The base currency against which exchange rates are calculated.
    var base: String?
    
    /// A dictionary of exchange rates, where keys are currency codes and values are exchange rates relative to the base currency.
    var rates: [String: Double]?
}
