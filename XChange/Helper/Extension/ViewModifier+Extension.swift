//
//  ViewModifier+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

/**
 This file defines an extension for SwiftUI's `ViewModifier`.
 */
public extension ViewModifier {
    
    /**
     A method to hide the keyboard.
     */
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
