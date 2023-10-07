//
//  XChangeApp.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 This file defines the main application structure and entry point for the XChange app. This documentation outlines the purpose of the `XChangeApp` struct and its role in configuring the app.
 
 ### Overview
 - `XChangeApp`: The main struct representing the XChange app.
 - `body`: The main scene of the app.
*/

import SwiftUI

/// The main struct representing the XChange app.
@main
struct XChangeApp: App {
    
    /// The main scene of the app.
    var body: some Scene {
        WindowGroup {
            MainAppView()
        }
    }
}
