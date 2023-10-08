//
//  UserDefaultsManagerTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class UserDefaultsManagerTests: XCTestCase {
    // A unique key for testing
    let testKey = TestUserDefaultKey.TEST_CACHE
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        // Clear any existing values in UserDefaults for the test key
        UserDefaultsManager.removeValue(forKey: testKey)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        // Clean up by removing the test key from UserDefaults
        UserDefaultsManager.removeValue(forKey: testKey)
    }
    
    // Test setting and retrieving a value in UserDefaults
    func testSetValueAndRetrieveValue() {
        let testValue = "Test Value"
        
        UserDefaultsManager.setValue(forKey: testKey, value: testValue)
        
        if let retrievedValue = UserDefaultsManager.getValue(forKey: testKey) as? String {
            XCTAssertEqual(retrievedValue, testValue)
        } else {
            XCTFail("Failed to retrieve the expected value from UserDefaults.")
        }
    }
    
    // Test removing a value from UserDefaults
    func testRemoveValue() {
        let testValue = "Test Value"
        
        UserDefaultsManager.setValue(forKey: testKey, value: testValue)
        UserDefaultsManager.removeValue(forKey: testKey)
        
        XCTAssertNil(UserDefaultsManager.getValue(forKey: testKey))
    }
}
