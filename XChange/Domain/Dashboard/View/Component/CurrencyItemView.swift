//
//  CurrencyItemView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `CurrencyItemView` view, which represents a single item displaying currency conversion information within the XChange application. This documentation provides an overview of the `CurrencyItemView` view and its functionality.
 
 ### Properties
 - `base`: A `CurrencyValueModel` representing the base currency.
 - `currency`: A `CurrencyValueModel` representing the target currency.
 
 ### Functionality
 The `CurrencyItemView` displays currency conversion information between the base currency and the target currency. It consists of the following components:
 */

import SwiftUI

struct CurrencyItemView: View {
    var base: CurrencyValueModel
    var currency: CurrencyValueModel
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(Constant.DEFAULT_BASE_CURRENCY_CODE)
                        .foregroundColor(.black.opacity(0.5))
                        .fontWeight(.bold)
                        .font(.headline)
                    
                    Image(systemName: "arrow.2.squarepath")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .rotationEffect(.degrees(90))
                    
                    Text(currency.code)
                        .foregroundColor(.black)
                        .fontWeight(.bold)
                        .font(.headline)
                }
                
                Text(currency.name)
                    .foregroundColor(.blackGray)
                    .fontWeight(.semibold)
                    .font(.caption)
                    .truncationMode(.tail)
                    .lineLimit(1)
                
                Spacer()
            }
            
            Spacer()

            Text(getConvertedRate())
                .foregroundColor(.black.opacity(0.8))
                .fontWeight(.bold)
                .font(.headline)
                .truncationMode(.tail)
                .lineLimit(1)
        }
        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
        .frame(height: 85)
        .background(
            Rectangle()
                .fill(.white)
                .cornerRadius(16)
                .shadow(radius: 0.5)
        )
    }
}

extension CurrencyItemView {
    
    /**
     This function calculates and returns the converted currency rate based on the provided base currency value and target currency rate. The result is displayed in the view, the calculation handled in the view in order to prevent many calculation at one time.
     .*/
    private func getConvertedRate() -> String {
        let convertedValue: Double = base.value * currency.rate
        return String(convertedValue.currency)
    }
}

struct CurrencyItemView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyItemView(
            base: .init(
                code: "USD",
                name: "United States Dollar",
                value: 0.0,
                rate: 20000
            ),
            currency: .init(
                code: "JPY",
                name: "Japanese Yen",
                value: 0.0,
                rate: 149.225
            )
        )
    }
}
