//
//  MainAppView.swift
//  XChange
//
//  Created by Aldo Vernando on 04/10/23.
//

import SwiftUI

struct MainAppView: View {
    
    var body: some View {
        NavigationView {
            Text("Main App View")
                .navigationTitle("XChange")
        }
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
