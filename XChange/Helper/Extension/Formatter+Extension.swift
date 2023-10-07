//
//  Formatter+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import Foundation

/**
 An extension for the Formatter type, providing methods and properties to simplify working with formatters.
 */
extension Formatter {
    /**
     A static instance of `NumberFormatter` for basic number formatting.
     */
    static let number = NumberFormatter()
    
    /**
     A static instance of `NumberFormatter` configured to format numbers with a grouping separator.
     
     This formatter is useful for formatting numbers with a grouping separator (e.g., comma or space).
     */
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
