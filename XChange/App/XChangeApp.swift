//
//  XChangeApp.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

import SwiftUI

@main
struct XChangeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
