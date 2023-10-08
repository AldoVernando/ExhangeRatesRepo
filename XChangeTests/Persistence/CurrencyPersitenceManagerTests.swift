//
//  CurrencyPersitenceManagerTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import CoreData
import XCTest

@testable import XChange

final class CurrencyPersitenceManagerTests: XCTestCase {
    var persistenceManager: CurrencyPersistenceManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        guard let dataModel = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else { return }
        let coordinator: NSPersistentStoreCoordinator = .init(managedObjectModel: dataModel)
        do {
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType,
                                       configurationName: nil,
                                       at: nil,
                                       options: nil);
        } catch {
            print("Error creating store: \(error)")
        }
        let context: NSManagedObjectContext = .init(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        
        persistenceManager = CurrencyPersistenceManager(managedContext: context)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        persistenceManager = nil
    }
    
    // Test creating a new currency data entry
    func testCreateCurrencyData() {
        let currencyModel = CurrencyRateModel(code: "USD", name: "US Dollar", rate: 1.0)
        
        persistenceManager.create(data: currencyModel)
        
        let retrievedCurrencies = persistenceManager.retrieve()
        XCTAssertNotNil(retrievedCurrencies)
        XCTAssertTrue(retrievedCurrencies?.count != 0)
        XCTAssertEqual(retrievedCurrencies?.first, currencyModel)
    }
    
    // Test updating an existing currency data entry
    func testUpdateCurrencyData() {
        let initialCurrencyModel = CurrencyRateModel(code: "USD", name: "US Dollar", rate: 1.0)
        let updatedCurrencyModel = CurrencyRateModel(code: "USD", name: "Updated Dollar", rate: 2.0)
        
        persistenceManager.create(data: initialCurrencyModel)
        persistenceManager.update(data: updatedCurrencyModel)
        
        let retrievedCurrencies = persistenceManager.retrieve()
        XCTAssertNotNil(retrievedCurrencies)
        XCTAssertTrue(retrievedCurrencies?.count != 0)
        XCTAssertEqual(retrievedCurrencies?.first, updatedCurrencyModel)
    }
    
    // Test deleting a currency data entry
    func testDeleteCurrencyData() {
        let currencyModel = CurrencyRateModel(code: "USD", name: "US Dollar", rate: 1.0)
        
        persistenceManager.create(data: currencyModel)
        persistenceManager.delete(data: currencyModel)
        
        let retrievedCurrencies = persistenceManager.retrieve()
        XCTAssertNotNil(retrievedCurrencies)
        XCTAssertTrue(retrievedCurrencies?.count == 0)
    }
    
    // Test checking if a currency data entry exists
    func testIsCurrencyDataExists() {
        let currencyModel = CurrencyRateModel(code: "USD", name: "US Dollar", rate: 1.0)
        
        XCTAssertFalse(persistenceManager.isDataExists(data: currencyModel))
        
        persistenceManager.create(data: currencyModel)
        XCTAssertTrue(persistenceManager.isDataExists(data: currencyModel))
    }
}
