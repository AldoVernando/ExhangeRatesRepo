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
            
            VStack(spacing: 8) {
                CurrencyExchangeView(
                    base: vm.baseCurrency,
                    target: vm.targetCurrency,
                    onTargetCurrencyTapped: vm.onTargetCurrencyTapped
                )
                
                textfieldSectionView()
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
        .padding(8)
        .dismissKeyboardHandler()
        .onAppear {
            vm.intiateView()
        }
    }
}

extension DashboardView {
    
    @ViewBuilder private func textfieldSectionView() -> some View {
        HStack {
            VStack(spacing: 8) {
                CurrencyTextfieldView(
                    symbol: "$",
                    placeholder: "0.00",
                    text: $vm.baseCurrencyTextfield.text
                )
                
                CurrencyTextfieldView(
                    symbol: "¤",
                    placeholder: "0.00",
                    text: $vm.targetCurrencyTextfield.text
                )
            }
            
            Image(systemName: "arrow.left.arrow.right")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.darkGray)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
