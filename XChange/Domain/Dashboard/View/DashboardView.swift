//
//  DashboardView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

struct DashboardView: View {
    
    var body: some View {
        VStack {
            CurrencyExchangeView(
                baseSymbol: "USD",
                targetSymbol: "JPY",
                baseValue: 200,
                targetValue: 3000,
                onTargetCurrencyTapped: {
                    print("Tapped")
                }
            )
            
            Spacer()
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
