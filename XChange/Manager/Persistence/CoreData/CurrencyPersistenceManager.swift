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
    func create(data model: CurrencyModel)
    
    /**
     Retrieves all stored currency data.
     
     - Returns: An array of currency models or nil if no data is found.
     */
    func retrieve() -> [CurrencyModel]?
    
    /**
     Updates an existing currency data entry.
     
     - Parameters:
     - model: The currency model with updated data.
     */
    func update(data model: CurrencyModel)
    
    /**
     Deletes a currency data entry.
     
     - Parameters:
     - model: The currency model to be deleted.
     */
    func delete(data model: CurrencyModel)
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
    func create(data model: CurrencyModel) {
        let managedContext = PersistenceController.shared.container.viewContext
        guard let currencyEntity = NSEntityDescription.entity(forEntityName: "Currency", in: managedContext)else {
            return
        }
        
        let insert = NSManagedObject(entity: currencyEntity, insertInto: managedContext)
        insert.setValue(model.code, forKey: "code")
        insert.setValue(model.name, forKey: "name")
        insert.setValue(model.rate, forKey: "rate")
        
        do {
            try managedContext.save()
        } catch {
            print("[Log] Failed while create currency entity.")
            print("[Error] \(error.localizedDescription)")
        }
    }
    
    /**
     Retrieves all stored currency data from the Core Data store.
     
     - Returns: An array of currency models or nil if no data is found.
     */
    func retrieve() -> [CurrencyModel]? {
        var currencies: [CurrencyModel] = []
        let managedContext = PersistenceController.shared.container.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Currency")
        
        do {
            guard let result = try managedContext.fetch(fetchRequest) as? [NSManagedObject] else {
                return nil
            }
            
            result.forEach { currency in
                currencies.append(
                    CurrencyModel(
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
    func update(data model: CurrencyModel) {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Currency")
        fetchRequest.predicate = NSPredicate(format: "code = %@", model.code)
        
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
    
    /**
     Deletes a currency data entry from the Core Data store.
     
     - Parameters:
     - model: The currency model to be deleted.
     */
    func delete(data model: CurrencyModel) {
        let managedContext = PersistenceController.shared.container.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Currency")
        fetchRequest.predicate = NSPredicate(format: "code = %@", model.code)
        
        do {
            guard let deleteObject = try? managedContext.fetch(fetchRequest)[0] as? NSManagedObject else { return }
            managedContext.delete(deleteObject)
            
            try managedContext.save()
        } catch {
            print("[Log] Failed while deleting currency entity.")
            print("[Error] \(error.localizedDescription)")
        }
    }
}
