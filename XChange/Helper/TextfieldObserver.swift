//
//  TextfieldObserver.swift
//  XChange
//
//  Created by Aldo Vernando on 07/10/23.
//

/**
 This file defines the `TextfieldObserver` class, which observes changes to a text field's input and provides a debounced version of the input text. This documentation provides an overview of the `TextfieldObserver` class and its functionality.
 
 ### Functionality
 The `TextfieldObserver` class observes changes to the `text` property and provides a debounced version of the input text in the `debouncedText` property. Debouncing is used to delay the handling of text changes, which can be useful for scenarios where you want to perform actions only after the user has finished typing or after a certain period of inactivity.
 
 The class uses Combine to achieve debouncing by:
 - Removing duplicate consecutive values from the `text` property.
 - Applying a debounce operation with the specified time interval using Combine's `.debounce()` operator.
 - Storing the debounced text in the `debouncedText` property.
 */

import Combine
import Foundation

final class TextfieldObserver : ObservableObject {
    /// A published property that holds the debounced version of the input text.
    @Published var debouncedText = ""
    
    /// A published property that holds the current input text.
    @Published var text = ""
    
    /// A set of cancellables for managing Combine subscriptions.
    private var cancellable = Set<AnyCancellable>()
    
    /**
     Initializes an instance of `TextfieldObserver` with a specified debounce time.
     
     - Parameter debounceTime: The debounce time interval (in seconds) to delay text changes.
     */
    init(debounceTime: Double) {
        $text
            .removeDuplicates()
            .debounce(for: .seconds(debounceTime), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                self?.debouncedText = value
            } )
            .store(in: &cancellable)
    }
}
