//
//  View+Extension.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

import SwiftUI

/**
 This file defines an extension for SwiftUI's `View`.
 */
extension View {
    
    /**
     Adds a modifier to the view for dismissing the keyboard.
     
     - Returns: A view with the dismiss keyboard modifier.
     */
    func dismissKeyboardHandler() -> some View {
        self.modifier(DismissKeyboardViewModifier())
    }
}
