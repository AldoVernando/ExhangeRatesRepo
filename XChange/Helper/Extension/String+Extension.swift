//
//  String+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import Foundation

/**
An extension for the String type, providing methods and properties to simplify working with strings.
*/
extension String {
    
    /// A computed property that converts a string to its double value representation.
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}
