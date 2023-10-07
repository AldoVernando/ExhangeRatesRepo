//
//  MainAppView.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

/**
 This file defines the main user interface structure of the XChange app. This documentation outlines the purpose of the `MainAppView` struct and its role in presenting the app's primary interface.
 
 ### Overview
 - `MainAppView`: The primary SwiftUI view representing the main interface of the app.
 
 The `MainAppView` struct serves as the main entry point for the XChange app, presenting the user interface for the app's core functionality.
 */

import SwiftUI

/// The primary SwiftUI view representing the main interface of the app.
struct MainAppView: View {
    
    var body: some View {
        NavigationView {
            DashboardView()
                .navigationBarHidden(true)
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
