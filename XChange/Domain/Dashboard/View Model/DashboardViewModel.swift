//
//  DashboardViewModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

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
        value: 0.0,
        rate: 0.0
    )
    @Published var targetCurrency: CurrencyValueModel = .init(
        code: "JPY",
        name: "Japanese Yen",
        value: 0.0,
        rate: 0.0
    )
    
    @Published var currenyRates: [CurrencyRateModel] = []
    
    private let service: ExchangeRateServiceProtocol
    private var cancellable: Set<AnyCancellable> = .init()
    
    private var isCalculation: Bool = false
    
    init(
        service: ExchangeRateServiceProtocol
    ) {
        self.service = service
        
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
}

extension DashboardViewModel {
    
    func intiateView() {
        Task {
            await getCurrencyData()
        }
    }
    
    func onTargetCurrencyTapped() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isDropdownHidden.toggle()
        }
    }
    
    func onTargetCurrencySelected(to item: CurrencyRateModel) {
        targetCurrency = .init(
            code: item.code,
            name: item.name,
            value: 0.0,
            rate: item.rate
        )
        isDropdownHidden = true
        convertCurrency(from: baseCurrency, to: targetCurrency)
    }
}

// Service
extension DashboardViewModel {
    
    private func getCurrencyData() async {
        do {
            guard let data: [CurrencyRateModel] = try await service.fetchCurrencyRate() else { return }
           
            await MainActor.run {
                currenyRates = data
                
                guard let defaultCurrency: CurrencyRateModel = data.first(where: { $0.code == Constant.DEFAULT_TARGET_CURRENCY_CODE }) else { return }
                targetCurrency = .init(
                    code: defaultCurrency.code,
                    name: defaultCurrency.name,
                    value: 0.0,
                    rate: defaultCurrency.rate
                )
            }
        } catch {
            print("[Log] Throw error while fetching currency rates data.")
            print("[Error] \(error.localizedDescription)")
        }
    }
    
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
