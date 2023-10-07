//
//  DashboardViewModel.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import Foundation

final class DashboardViewModel: ObservableObject {
    // Input
    @Published var currencyTextfield: String = "" {
        didSet {
            baseValue = currencyTextfield.doubleValue
        }
    }
    
    @Published var baseSymbol: String = "USD"
    @Published var targetSymbol: String = "JPY"
    
    @Published var baseValue: Double = 0.0
}
