//
//  DismissKeyboardViewModifier.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines a SwiftUI view modifier `DismissKeyboardViewModifier` that adds a tap gesture to dismiss the keyboard when tapping outside of a text input field. This documentation outlines the purpose of the view modifier and its usage.
 
 ### Overview
 - `DismissKeyboardViewModifier`: A view modifier for dismissing the keyboard.
 
 This view modifier is useful for improving the user experience in SwiftUI views by allowing users to dismiss the keyboard with a tap gesture anywhere outside of a text input field.
*/

import SwiftUI

/// A view modifier for dismissing the keyboard.
public struct DismissKeyboardViewModifier: ViewModifier {
    
    public func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        self.hideKeyboard()
                    }
            )
    }
}
