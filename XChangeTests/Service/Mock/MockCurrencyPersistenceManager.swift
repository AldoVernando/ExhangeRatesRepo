//
//  MockCurrencyPersistenceManager.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import Foundation

@testable import XChange

class MockCurrencyPersistenceManager: CurrencyPersistenceManagerProtocol {
    var currencies: [CurrencyRateModel] = []
    
    func create(data model: CurrencyRateModel) {
        currencies.append(model)
    }
    
    func retrieve() -> [CurrencyRateModel]? {
        return currencies
    }
    
    func update(data model: CurrencyRateModel) {
        if let index = currencies.firstIndex(where: { $0.code == model.code }) {
            currencies[index] = model
        }
    }
    
    func delete(data model: CurrencyRateModel) {
        if let index = currencies.firstIndex(where: { $0.code == model.code }) {
            currencies.remove(at: index)
        }
    }
    
    func isDataExists(data model: CurrencyRateModel) -> Bool {
        return currencies.contains(where: { $0.code == model.code })
    }
}
