//
//  Persistence.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 This file defines the `PersistenceController` struct, which is responsible for managing the Core Data stack and provides a shared instance of the Core Data container. This documentation outlines the purpose of the `PersistenceController` and its role in managing Core Data in the application.
 
 ### Overview
 - `shared`: A static property that provides a shared instance of the `PersistenceController`.
 - `container`: The Core Data container used to manage the data store.
 
 The `PersistenceController` struct encapsulates the Core Data stack initialization and provides a convenient way to access the Core Data container.
 */

import CoreData

struct PersistenceController {
    /// A shared instance of the PersistenceController.
    static let shared = PersistenceController()

    /// The Core Data container used to manage the data store.
    let container: NSPersistentContainer

    /// Initializes the Core Data stack.
    ///
    /// - Parameter inMemory: A boolean value indicating whether to use an in-memory store.
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "XChange")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
