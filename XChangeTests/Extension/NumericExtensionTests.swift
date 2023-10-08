//
//  NumericExtensionTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class NumericExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNumberFormattingWithCommaSeparator() {
        let number: Double = 1234567.89
        let formatted = number.formatted(with: ",", style: .decimal)
        XCTAssertEqual(formatted, "1,234,567.89")
    }
    
    func testNumberFormattingWithPeriodSeparator() {
        let number: Double = 1234.567
        let formatted = number.formatted(with: ".", style: .decimal)
        XCTAssertEqual(formatted, "1.234.567")
    }
    
    func testNumberFormattingWithCustomSeparator() {
        let number: Double = 1234567.89
        let formatted = number.formatted(with: "_", style: .decimal)
        XCTAssertEqual(formatted, "1_234_567.89")
    }
    
    func testNumberFormattingWithScientificStyle() {
        let number: Double = 12345.67
        let formatted = number.formatted(style: .scientific)
        XCTAssertEqual(formatted, "1.234567E4")
    }
    
    func testNumberFormattingWithCurrencyStyle() throws {
        // Set up the number will be use to be format
        let number: Int = 24000000
        
        // Action to format the number in the currency style with en_US locale
        let formattedNumber: String = number.formatted(with: " ", style: .currency, locale: .init(identifier: "en_US"))
        
        // Test the result must be equal with the expected result
        let expectedResult: String = "$24,000,000.00"
        XCTAssertEqual(formattedNumber, expectedResult)
    }
}
