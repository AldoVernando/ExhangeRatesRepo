//
//  TestUserDefaultKey.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import Foundation

@testable import XChange

enum TestUserDefaultKey: String, UserDefaultsKey {
    case TEST_CACHE
    
    var value: String {
        self.rawValue
    }
}
