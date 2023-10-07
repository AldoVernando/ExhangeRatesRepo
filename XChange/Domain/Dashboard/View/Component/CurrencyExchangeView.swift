//
//  CurrencyExchangeView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines a SwiftUI `View` named `CurrencyExchangeView` for displaying currency exchange information. It includes the exchange rate between a base currency and a target currency, as well as user interactions to switch the target currency. This documentation provides an overview of the `CurrencyExchangeView` structure and its purpose.
 
 ### Overview
 - `baseSymbol`: The symbol of the base currency.
 - `targetSymbol`: The symbol of the target currency.
 - `baseValue`: The value of the base currency.
 - `targetValue`: The value of the target currency.
 - `onTargetCurrencyTapped`: A closure to handle when the target currency is tapped.
 
 The view consists of two custom shapes representing the base and target currencies, with their respective values and symbols displayed. Tapping the target currency section triggers the `onTargetCurrencyTapped` closure.

 ### Example
 CurrencyExchangeView(
    baseSymbol: "USD",
    targetSymbol: "THB",
    baseValue: 200,
    targetValue: 3000,
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
    /// The symbol of the base currency.
    let baseSymbol: String
    
    /// The symbol of the target currency.
    let targetSymbol: String
    
    /// The value of the base currency.
    let baseValue: Double
    
    /// The value of the target currency.
    let targetValue: Double
    
    /// A closure to handle when the target currency is tapped.
    let onTargetCurrencyTapped: () -> Void
    
    var body: some View {
        ZStack {
            CustomeExchangeShape()
                .fill(Color("dark-gray"))
                .frame(height: 75)
                .offset(x: 20)
                .background(Color("light-gray"))
                .cornerRadius(8)
                .onTapGesture(perform: onTargetCurrencyTapped)
            
            CustomeExchangeShape()
                .fill(Color("gray-black"))
                .frame(height: 75)
                .cornerRadius(8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(baseSymbol)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.title)
                    
                    Text(String(baseValue.currency))
                        .foregroundColor(Color("light-gray"))
                        .fontWeight(.semibold)
                        .font(.headline)
                        .truncationMode(.tail)
                        .frame(width: 150, alignment: .leading)
                        .lineLimit(1)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(targetSymbol)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .font(.title)
                        
                        Image(systemName: "chevron.down.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Text(String(targetValue.currency))
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
            baseSymbol: "USD",
            targetSymbol: "THB",
            baseValue: 200,
            targetValue: 3000,
            onTargetCurrencyTapped: {
                print("Tapped")
            }
        )
    }
}
