//
//  DashboardView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject private var vm: DashboardViewModel = .init(
        service: ExchangeRateService(
            network: NetworkManager(),
            storage: CurrencyPersistenceManager()
        )
    )
        
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 20) {
                
                CurrencyExchangeView(
                    base: vm.baseCurrency,
                    target: vm.targetCurrency,
                    onTargetCurrencyTapped: vm.onTargetCurrencyTapped
                )
                
                textfieldView()
                    .padding(.horizontal, 2)
                
                Spacer()
            }
            
            if !vm.isDropdownHidden {
                DropdownView(
                    items: vm.currenyRates,
                    onItemTapped: { item in
                        vm.onTargetCurrencySelected(to: item)
                    }
                )
                .offset(x: 0, y: 85)
                .opacity(vm.isDropdownHidden ? 0 : 1)
            }
        }
        .padding()
        .dismissKeyboardHandler()
        .onAppear {
            vm.intiateView()
        }
    }
}

extension DashboardView {
    
    @ViewBuilder private func textfieldView() -> some View {
        HStack(alignment: .center, spacing: 8) {
            Text("$")
                .foregroundColor(Color.blackGray)
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
        )    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
