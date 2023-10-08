//
//  DateExtensionTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class DateExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTimeDiff() throws {
        let calendar: Calendar = .init(identifier: .gregorian)
        
        // Set up the previous date
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 9
        dateComponents.day = 5
        dateComponents.hour = 1
        dateComponents.minute = 20 // since the components above (like year 1980) are for Gregorian
        let previousDate: Date? = calendar.date(from: dateComponents)
        
        // Set up the previous date
        dateComponents.year = 2023
        dateComponents.month = 10
        dateComponents.day = 8
        dateComponents.hour = 12
        dateComponents.minute = 48
        let currentDate: Date? = calendar.date(from: dateComponents)
        
        guard let previousDate = previousDate,
              let currentDate = currentDate
        else {
            XCTFail("Dates to be compare found nil.")
            return
        }
        
        measure {
            // Action to get the time diff
            let timeDiff = previousDate.timeDiff(for: currentDate)
            
            let expectedResult = (month: 1, day: 33, hour: 803, minute: 48208, second: 2892480)
            
            // Test the result must be equal with the expected result
            XCTAssertEqual(timeDiff.month, expectedResult.month)
            XCTAssertEqual(timeDiff.day, expectedResult.day)
            XCTAssertEqual(timeDiff.hour, expectedResult.hour)
            XCTAssertEqual(timeDiff.minute, expectedResult.minute)
            XCTAssertEqual(timeDiff.second, expectedResult.second)
        }
    }
}
