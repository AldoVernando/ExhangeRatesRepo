//
//  DropdownView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `DropdownView` SwiftUI view, which displays a dropdown list of currency items. Users can tap an item to select it. This documentation provides an overview of the view, its properties, and usage.
 
 ### Overview
 - `DropdownView`: A SwiftUI view for displaying a dropdown list of currency items.
 - `items`: An array of `CurrencyRateModel` representing the currency items to display.
 - `onItemTapped`: A closure to handle when a currency item is tapped.
 
 This view is designed for presenting a list of currency items in a dropdown format, allowing users to select a specific currency.
 
 ### Example
 DropdownView(
     items: [
         .init(code: "JPY", name: "Japanese Yen", rate: 10.0),
         .init(code: "EUR", name: "Euro", rate: 300.0)
     ],
     onItemTapped: { selectedCurrency in
         print("Selected currency: \(selectedCurrency.code)")
     }
 )
*/

import SwiftUI

/**
 A SwiftUI view for displaying a dropdown list of currency items.
 */
struct DropdownView: View {
    /// An array of CurrencyRateModel representing the currency items to display.
    let items: [CurrencyRateModel]
    
    /// A closure to handle when a currency item is tapped.
    let onItemTapped: (CurrencyRateModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(Array(items.enumerated()), id: \.element.code) { index, item in
                    itemView(at: index, for: item)
                        .onTapGesture(perform: { onItemTapped(item) })
                }
            }
        }
        .frame(width: 120, height: 300, alignment: .trailing)
        .background(
            Rectangle()
                .fill(Color.cream)
                .cornerRadius(16)
        )
    }
}

extension DropdownView {
    
    @ViewBuilder private func itemView(at index: Int, for item: CurrencyRateModel) -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            Text(item.code)
                .foregroundColor(Color.blackGray)
                .fontWeight(.semibold)
                .font(.headline)
            
            Text(item.name)
                .foregroundColor(.gray)
                .font(.caption)
                .lineLimit(1)
                .truncationMode(.tail)
        }
        .padding(8)
        .frame(width: 120, alignment: .trailing)
        .background(
            index % 2 == 0 ? Color.white.opacity(0.6) : Color.white.opacity(0.8)
        )
    }
}

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        DropdownView(
            items: [
                .init(code: "JPY", name: "Japanese Yen", rate: 10.0),
                .init(code: "EUR", name: "Euro", rate: 300.0)
            ],
            onItemTapped: { _ in
                print("Tapped")
            }
        )
    }
}
