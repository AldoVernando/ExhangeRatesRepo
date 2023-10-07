//
//  Color+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines an extension for SwiftUI's `Color` to provide custom color constants. This documentation outlines the purpose of the extension and its color constants.

 ### Example
 struct ContentView: View {
     var body: some View {
         Text("Custom Color Example")
             .foregroundColor(Color.blackGray)
             .background(Color.cream)
     }
 }
*/

import SwiftUI

extension Color {
    
    static let blackGray: Color = .init("black-gray")
    
    static let cream: Color = .init("cream")
    
    static let darkGray: Color = .init("dark-gray")
    
    static let lightGray: Color = .init("light-gray")
}
