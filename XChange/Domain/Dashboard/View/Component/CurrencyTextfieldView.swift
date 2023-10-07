//
//  CurrencyTextfieldView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `CurrencyTextfieldView` SwiftUI view, which displays a text field for entering currency values. The view includes a currency symbol, a placeholder, and enforces a maximum digit limit. This documentation provides an overview of the `CurrencyTextfieldView` and its properties.
 
 ### Properties
 - `symbol`: The currency symbol displayed before the text field.
 - `placeholder`: The placeholder text displayed in the text field.
 - `text`: A binding to a String value that represents the text entered in the text field.
 - `limit`: The maximum digit limit allowed in the text field.
 
 ### View Components
 - A `Text` view displaying the currency symbol.
 - A `TextField` view for entering currency values.
 - Validation for enforcing the maximum digit limit.
 */

import Combine
import SwiftUI

struct CurrencyTextfieldView: View {
    /// The currency symbol displayed before the text field.
    let symbol: String
    
    /// The placeholder text displayed in the text field.
    let placeholder: String
    
    /// A binding to a String value that represents the text entered in the text field.
    @Binding var text: String
    
    /// The maximum digit limit allowed in the text field.
    let limit: Int = Constant.DEFAULT_MAX_DIGIT_LIMIT
    
    var body: some View {
        HStack {
            Text(symbol)
                .foregroundColor(Color.blackGray)
                .fontWeight(.semibold)
                .font(.title)
            
            TextField(placeholder, text: $text)
                .font(.headline)
                .textFieldStyle(.plain)
                .keyboardType(.decimalPad)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
        )
        .onReceive(Just(text)) { value in
            guard value.count > limit else { return }
            text = String(value.prefix(limit))
        }
    }
}

struct CurrencyTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyTextfieldView(
            symbol: "$",
            placeholder: "0.00",
            text: .constant("")
        )
    }
}
