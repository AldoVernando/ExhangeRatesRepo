//
//  Numeric+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import Foundation

/**
 An extension for numeric types, providing methods and properties for formatting numeric values as strings.
 */
extension Numeric {
    
    /**
     Formats a numeric value as a string with customizable options for grouping separator, number style, and locale.
     
     - Parameters:
     - groupingSeparator: The character used as the grouping separator (e.g., comma or space).
     - style: The number style to apply (e.g., decimal, currency).
     - locale: The locale to use for formatting.
     - Returns: A formatted string representation of the numeric value.
     */
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .current) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }
        return Formatter.number.string(for: self) ?? ""
    }
    
    /**
     A computed property that formats the numeric value as a currency string.
     
     This property uses the default currency style and locale for formatting.
     */
    var currency: String { formatted(style: .currency, locale: .init(identifier: "")) }
    
    /**
     A computed property that formats the numeric value as a currency string in united states locale.
     
     This property uses the default currency style and en_US locale for formatting.
     */
    var usdCurrency: String { formatted(style: .currency, locale: .init(identifier: "en_US")) }
}
