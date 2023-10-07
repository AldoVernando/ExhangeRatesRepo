//
//  DashboardView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject private var vm: DashboardViewModel = .init()
    
    var body: some View {
        VStack(spacing: 20) {
            CurrencyExchangeView(
                baseSymbol: vm.baseSymbol,
                targetSymbol: vm.targetSymbol,
                baseValue: vm.baseValue,
                targetValue: 3000,
                onTargetCurrencyTapped: {
                    print("Tapped")
                }
            )
            
            textfieldView()
            
            Spacer()
        }
        .padding()
    }
}

extension DashboardView {
    
    @ViewBuilder private func textfieldView() -> some View {
        HStack(alignment: .center, spacing: 8) {
            Text("$")
                .foregroundColor(Color("gray-black"))
                .fontWeight(.semibold)
                .font(.title)
            
            TextField("0.00", text: $vm.currencyTextfield)
                .font(.headline)
                .keyboardType(.decimalPad)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
        )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
