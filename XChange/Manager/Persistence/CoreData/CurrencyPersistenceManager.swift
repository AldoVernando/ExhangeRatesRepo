//
//  CurrencyPersistenceManager.swift
//  XChange
//
//  Created by Aldo Vernando on 05/10/23.
//

/**
 This file defines the `CurrencyPersistenceManager` class, which is responsible for managing the persistence of currency data using Core Data. The class conforms to the `CurrencyPersistenceManagerProtocol` and provides documentation for its public methods.
 */

import CoreData

/**
 A protocol that defines the structure of a currency persistence manager for managing currency data.
 */
protocol CurrencyPersistenceManagerProtocol {
    /**
     Creates a new currency data entry.
     
     - Parameters:
     - model: The currency model to be created.
     */
    func create(data model: CurrencyRateModel)
    
    /**
     Retrieves all stored currency data.
     
     - Returns: An array of currency models or nil if no data is found.
     */
    func retrieve() -> [CurrencyRateModel]?
    
    /**
     Updates an existing currency data entry.
     
     - Parameters:
     - model: The currency model with updated data.
     */
    func update(data model: CurrencyRateModel)
    
    /**
     Deletes a currency data entry.
     
     - Parameters:
     - model: The currency model to be deleted.
     */
    func delete(data model: CurrencyRateModel)
    
    /**
     Checks if a currency data entry exists.
     
     - Parameters:
     - model: The currency model to be checked.
     */
    func isDataExists(data model: CurrencyRateModel) -> Bool
}

/**
 A class responsible for managing the persistence of currency data using Core Data.
 */
final class CurrencyPersistenceManager: CurrencyPersistenceManagerProtocol {
    
    /**
     Creates a new currency data entry in the Core Data store.
     
     - Parameters:
     - model: The currency model to be created.
     */
    func create(data model: CurrencyRateModel) {
        let managedContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        guard let currencyEntity: NSEntityDescription = .entity(forEntityName: "Currency", in: managedContext) else {
            return
        }
        
        managedContext.performAndWait {
            do {
                let insertObject: NSManagedObject = .init(entity: currencyEntity, insertInto: managedContext)
                insertObject.setValue(model.code, forKey: "code")
                insertObject.setValue(model.name, forKey: "name")
                insertObject.setValue(model.rate, forKey: "rate")
                
                try managedContext.save()
            } catch {
                print("[Log] Failed while create currency entity.")
                print("[Error] \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Retrieves all stored currency data from the Core Data store.
     
     - Returns: An array of currency models or nil if no data is found.
     */
    func retrieve() -> [CurrencyRateModel]? {
        let managedContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Currency")
        var currencies: [CurrencyRateModel] = []
        
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            
            result.forEach { currency in
                currencies.append(
                    CurrencyRateModel(
                        code: currency.value(forKey: "code") as? String ?? "Currency_Code",
                        name: currency.value(forKey: "name") as? String ?? "Currency_Name",
                        rate: currency.value(forKey: "rate") as? Double ?? 0.0
                    )
                )
            }
        } catch {
            print("[Log] Failed while retrieving currency entity.")
            print("[Error] \(error.localizedDescription)")
        }
        return currencies
    }
    
    /**
     Updates an existing currency data entry in the Core Data store.
     
     - Parameters:
     - model: The currency model with updated data.
     */
    func update(data model: CurrencyRateModel) {
        let managedContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Currency")
        fetchRequest.predicate = NSPredicate(format: "code = %@", model.code)
        
        managedContext.performAndWait {
            do {
                let fetch = try managedContext.fetch(fetchRequest)
                guard let updateObject = fetch[0] as? NSManagedObject else { return }
                updateObject.setValue(model.code, forKey: "code")
                updateObject.setValue(model.name, forKey: "name")
                updateObject.setValue(model.rate, forKey: "rate")
                
                try managedContext.save()
            } catch {
                print("[Log] Failed while updating currency entity.")
                print("[Error] \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Deletes a currency data entry from the Core Data store.
     
     - Parameters:
     - model: The currency model to be deleted.
     */
    func delete(data model: CurrencyRateModel) {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Currency")
        fetchRequest.predicate = NSPredicate(format: "code = %@", model.code)
        
        managedContext.performAndWait {
            do {
                guard let deleteObject = try managedContext.fetch(fetchRequest)[0] as? NSManagedObject else { return }
                managedContext.delete(deleteObject)
                
                try managedContext.save()
            } catch {
                print("[Log] Failed while deleting currency entity.")
                print("[Error] \(error.localizedDescription)")
            }
        }
    }
    
    /**
     Checks if a currency data entry exists.
     
     - Parameters:
     - model: The currency model to be checked.
     */
    func isDataExists(data model: CurrencyRateModel) -> Bool {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: "Currency")
        fetchRequest.predicate = NSPredicate(format: "code = %@", model.code)
        
        do {
            guard let fetchResults = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return false
            }
            return fetchResults.count != 0
        } catch {
            print("[Log] Failed while checking entity existence.")
            print("[Error] \(error.localizedDescription)")
        }
        return false
    }
}
