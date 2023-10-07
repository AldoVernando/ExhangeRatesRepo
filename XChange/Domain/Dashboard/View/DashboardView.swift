//
//  DashboardView.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `DashboardView` view, which represents the main dashboard screen of the XChange application. This documentation provides an overview of the `DashboardView` view and its functionality.
 
 ### Properties
 - `vm`: An `ObservedObject` of the `DashboardViewModel` responsible for managing the data and logic of the dashboard.
 
 ### Functionality
 The `DashboardView` is the central screen of the XChange application, providing the following functionality:
 
 - Currency Exchange View: Displays the base currency, target currency, and exchange rate. Users can tap on the target currency to select a different one.
 
 - Textfield Section View: Allows users to input currency values for both the base and target currencies. The exchange rate is calculated and displayed when the values change.
 
 - Currencies Section View: Displays a list of currency conversion items, each showing the converted rate based on the input values.
 
 - DropdownView: A dropdown list of available currencies for selecting the target currency. It appears when the user taps on the target currency field.
 
 - RefreshableScrollView: Allows users to refresh the list of currency conversion items with the latest rates by pulling down the screen.
 
 - Interaction with `DashboardViewModel`: The view interacts with the `DashboardViewModel` to manage data, perform currency conversions, and update the UI. It uses Combine to observe changes in the view model's properties.
 */

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
            
            VStack(spacing: 0) {
                Group {
                    CurrencyExchangeView(
                        base: vm.baseCurrency,
                        target: vm.targetCurrency,
                        onTargetCurrencyTapped: vm.onTargetCurrencyTapped
                    )
                    
                    textfieldSectionView()
                        .padding(.horizontal, 2)
                }
                .padding(8)
                
                currenciesSectionView()
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
                .padding(8)
            }
        }
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
    
    @ViewBuilder private func currenciesSectionView() -> some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(Color.cream.opacity(0.4))
                .cornerRadius(48)
                .offset(y: 50)
            
            ScrollView {
                RefreshableScrollView(
                    coordinateSpace: .named("RefreshableScrollView"),
                    onRefresh: vm.onRefreshCurrencyRates
                )
                
                LazyVStack(spacing: 8) {
                    ForEach(vm.currenyRates, id: \.code) { currency in
                        CurrencyItemView(
                            base: vm.baseCurrency,
                            currency: currency
                        )
                        .padding(.horizontal, 8)
                    }
                }
                .padding(.bottom, 16)
            }
            .coordinateSpace(name: "RefreshableScrollView")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
