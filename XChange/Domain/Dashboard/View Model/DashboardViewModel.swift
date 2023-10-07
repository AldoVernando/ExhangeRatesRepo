//
//  DashboardViewModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import Foundation
import SwiftUI

final class DashboardViewModel: ObservableObject {
    // View Interactions
    @Published var currencyTextfield: String = "" {
        didSet {
            baseCurrency.value = currencyTextfield.doubleValue
        }
    }
    @Published var isDropdownHidden: Bool = true
    
    // Data
    @Published var baseCurrency: CurrencyValueModel = .init(
        code: "USD",
        name: "United States Dollar",
        value: 0.0
    )
    @Published var targetCurrency: CurrencyValueModel = .init(
        code: "JPY",
        name: "Japanese Yen",
        value: 0.0
    )
    
    @Published var currenyRates: [CurrencyRateModel] = []
    
    private let service: ExchangeRateServiceProtocol
    
    init(
        service: ExchangeRateServiceProtocol
    ) {
        self.service = service
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
            value: 0.0
        )
        isDropdownHidden = true
    }
}

// Service
extension DashboardViewModel {
    
    private func getCurrencyData() async {
        do {
            guard let data: [CurrencyRateModel] = try await service.fetchCurrencyRate() else { return }
           
            await MainActor.run {
                currenyRates = data
            }
        } catch {
            print("[Log] Throw error while fetching currency rates data.")
            print("[Error] \(error.localizedDescription)")
        }
    }
}
