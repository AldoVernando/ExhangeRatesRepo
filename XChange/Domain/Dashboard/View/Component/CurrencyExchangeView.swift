//
//  CurrencyExchangeView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines a SwiftUI view, `CurrencyExchangeView`, for displaying currency exchange information and handling user interactions to switch the target currency. This documentation provides an overview of the view, its properties, and usage.
 
 ### Overview
 - `CurrencyExchangeView`: A SwiftUI view that displays currency exchange information with a customizable base and target currency. Users can tap the target currency to switch it.
 - `base`: The base currency to display.
 - `target`: The target currency to display.
 - `onTargetCurrencyTapped`: A closure to handle when the target currency is tapped.
 
 This view is designed for presenting currency exchange details in a user-friendly format, allowing users to interact with and switch the target currency.
 
 ### Example
 CurrencyExchangeView(
     base: .init(
         code: "USD",
         name: "United States Dollar",
         value: 0.0
     ),
     target: .init(
         code: "JPY",
         name: "Japanese Yen",
         value: 0.0
     ),
     onTargetCurrencyTapped: {
         print("Tapped")
     }
 )
 */

import SwiftUI

/**
 A SwiftUI View for displaying currency exchange information and handling user interactions to switch the target currency.
 */
struct CurrencyExchangeView: View {
    /// The base currency.
    let base: CurrencyValueModel
    
    /// The  target currency.
    let target: CurrencyValueModel
    
    /// A closure to handle when the target currency is tapped.
    let onTargetCurrencyTapped: () -> Void
    
    var body: some View {
        ZStack {
            CustomeExchangeShape()
                .fill(Color.darkGray)
                .frame(height: 75)
                .offset(x: 20)
                .background(Color.lightGray)
                .cornerRadius(8)
                .onTapGesture(perform: onTargetCurrencyTapped)
            
            CustomeExchangeShape()
                .fill(Color.blackGray)
                .frame(height: 75)
                .cornerRadius(8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(base.code)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text(String(base.value.currency))
                        .foregroundColor(Color.lightGray)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(target.code)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Image(systemName: "chevron.down.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(String(target.value.currency))
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .trailing)
                        .lineLimit(1)
                }
                .onTapGesture(perform: onTargetCurrencyTapped)
            }
            .padding()
        }
    }
}

struct CurrencyExchangeView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeView(
            base: .init(
                code: "USD",
                name: "United States Dollar",
                value: 0.0
            ),
            target: .init(
                code: "JPY",
                name: "Japanese Yen",
                value: 0.0
            ),
            onTargetCurrencyTapped: {
                print("Tapped")
            }
        )
    }
}
