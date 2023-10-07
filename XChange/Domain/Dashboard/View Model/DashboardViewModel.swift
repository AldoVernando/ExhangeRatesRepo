//
//  DashboardViewModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `DashboardViewModel` class, which is responsible for managing the data and logic of the dashboard view in the XChange application. This documentation provides an overview of the `DashboardViewModel` class and its functionality.

 ### Properties

 - `baseCurrencyTextfield`: An instance of `TextfieldObserver` used for observing changes in the base currency textfield's text.
 - `targetCurrencyTextfield`: An instance of `TextfieldObserver` used for observing changes in the target currency textfield's text.
 - `isDropdownHidden`: A Boolean indicating whether the dropdown for selecting the target currency is hidden.
 - `baseCurrency`: The base currency model containing code, name, value, and rate.
 - `targetCurrency`: The target currency model containing code, name, value, and rate.
 - `currenyRates`: An array of `CurrencyValueModel` representing the list of currency conversion rates.
 - `service`: An instance conforming to the `ExchangeRateServiceProtocol` used for fetching currency data.
 - `cancellable`: A set of cancellable objects for managing Combine subscriptions.
 - `isCalculation`: A Boolean indicating whether a currency conversion calculation is in progress.
 */

import Combine
import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    // View Interactions
    @Published var baseCurrencyTextfield: TextfieldObserver = .init(debounceTime: 0.5)
    @Published var targetCurrencyTextfield: TextfieldObserver = .init(debounceTime: 0.5)
    @Published var isDropdownHidden: Bool = true
    
    // Data
    @Published var baseCurrency: CurrencyValueModel = .init(
        code: "USD",
        name: "United States Dollar",
        value: 1.0,
        rate: 0.0
    )
    @Published var targetCurrency: CurrencyValueModel = .init(
        code: "JPY",
        name: "Japanese Yen",
        value: 0.0,
        rate: 0.0
    )
    
    @Published var currenyRates: [CurrencyValueModel] = []
    
    private let service: ExchangeRateServiceProtocol
    private var cancellable: Set<AnyCancellable>
    private var isCalculation: Bool
    
    // Initialization: It initializes the view model, including setting up Combine publishers and initial values.
    init(
        service: ExchangeRateServiceProtocol
    ) {
        self.service = service
        self.cancellable = .init()
        self.isCalculation = true
        
        setObservers()
    }
}

// MARK: - View Interactions
extension DashboardViewModel {
    
    /**
     Initiates the view by fetching currency data asynchronously from the service.
     - Usage: Called when the dashboard view is first loaded.
     */
    func intiateView() {
        Task {
            await getCurrencyData()
        }
    }
    
    /**
     Toggles the visibility of the target currency dropdown with a smooth animation.
     - Usage: Called when the user taps on the target currency field.
     */
    func onTargetCurrencyTapped() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isDropdownHidden.toggle()
        }
    }
    /**
     Handles the selection of a target currency from the dropdown. Updates the target currency and triggers currency conversion.
     - Parameters:
        - `item`: The selected `CurrencyValueModel` representing the chosen target currency.
     - Usage: Called when a currency is selected from the dropdown.
     */
    func onTargetCurrencySelected(to item: CurrencyValueModel) {
        targetCurrency = item
        isDropdownHidden = true
        convertCurrency(from: baseCurrency, to: targetCurrency)
    }
    
    /**
     Initiates a refresh of currency rates data by fetching it asynchronously from the service.
     - Usage: Called when the user triggers a manual refresh of currency rates.
     */
    func onRefreshCurrencyRates() {
        Task {
            await getCurrencyData()
        }
    }
}

//MARK: - Logic Handle
extension DashboardViewModel {
    
    /**
     Observing Textfield Changes: It observes changes in the textfields for both base and target currencies using `TextfieldObserver`. It debounces text changes to avoid unnecessary calculations.
     */
    private func setObservers() {
        baseCurrencyTextfield
            .$debouncedText
            .sink { [weak self] value in
                guard let self = self,
                      !self.isCalculation
                else {
                    self?.isCalculation = false
                    return
                }
                
                self.baseCurrency.value = value.doubleValue
                self.convertCurrency(from: self.baseCurrency, to: self.targetCurrency)
            }
            .store(in: &cancellable)
        
        targetCurrencyTextfield
            .$debouncedText
            .sink { [weak self] value in
                guard let self = self,
                      !self.isCalculation
                else {
                    self?.isCalculation = false
                    return
                }
                
                self.targetCurrency.value = value.doubleValue
                self.convertCurrency(from: self.targetCurrency, to: self.baseCurrency)
            }
            .store(in: &cancellable)
    }
    
    /**
     Performs currency conversion based on the exchange rate between the base and target currencies. It updates the values and text in the textfields for both currencies.
     - Parameters:
       - `base`: The base currency model.
       - `target`: The target currency model.
     - Usage: Called when the user enters values in the currency textfields.
     */
    private func convertCurrency(from base: CurrencyValueModel, to target: CurrencyValueModel) {
        guard base.value > 0 else { return }
        isCalculation = true
        
        var convertedValue: Double
        if base.code == Constant.DEFAULT_BASE_CURRENCY_CODE {
            convertedValue = base.value * target.rate
            targetCurrency.value = convertedValue
            targetCurrencyTextfield.text = String(format: "%.2f", convertedValue)
        } else {
            convertedValue = base.value / base.rate
            baseCurrency.value = convertedValue
            baseCurrencyTextfield.text = String(format: "%.2f", convertedValue)
        }
    }
}

// MARK: - Service
extension DashboardViewModel {
    
    /**
     Fetches the latest currency data asynchronously from the service and updates the list of currency conversion rates. It also sets the default target currency and initializes the base currency textfield with its value.
     - Usage: Called during the initialization of the view model and after a manual refresh of currency rates.
     */
    private func getCurrencyData() async {
        do {
            guard let data: [CurrencyRateModel] = try await service.fetchCurrencyRate() else { return }
            
            await MainActor.run {
                currenyRates = data.map { item in
                        .init(
                            code: item.code,
                            name: item.name,
                            value: 0.0,
                            rate: item.rate
                        )
                }
                
                guard let defaultCurrency: CurrencyRateModel = data.first(where: { $0.code == Constant.DEFAULT_TARGET_CURRENCY_CODE }) else { return }
                targetCurrency = .init(
                    code: defaultCurrency.code,
                    name: defaultCurrency.name,
                    value: 0.0,
                    rate: defaultCurrency.rate
                )
                baseCurrencyTextfield.text = String(baseCurrency.value)
            }
        } catch {
            print("[Log] Throw error while fetching currency rates data.")
            print("[Error] \(error.localizedDescription)")
        }
    }
}
