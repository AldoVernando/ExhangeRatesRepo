//
//  DashboardViewModelTests.swift
//  XChangeTests
//
//  Created by Aldo Vernando on 08/10/23.
//

import XCTest

@testable import XChange

final class DashboardViewModelTests: XCTestCase {
    var viewModel: DashboardViewModel!
    var mockService: MockExchangeRateService!
    
    override func setUp() {
        super.setUp()
        mockService = .init()
        viewModel = DashboardViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    // Test the initiation of the view model
    func testInitiation() {
        viewModel.intiateView()
        
        XCTAssertEqual(viewModel.baseCurrency.code, "USD")
        XCTAssertEqual(viewModel.targetCurrency.code, "JPY")
        XCTAssertTrue(viewModel.isDropdownHidden)
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            XCTAssertFalse(self?.viewModel.currenyRates.isEmpty ?? true)
            XCTAssertEqual(self?.viewModel.state, .loaded)
        }
    }
    
    // Test the action on target currency tapped of the view model
    func testOnTargetCurrencyTapped() {
        let previusDropdownState: Bool = viewModel.isDropdownHidden
        viewModel.onTargetCurrencyTapped()
        
        XCTAssertNotEqual(viewModel.isDropdownHidden, previusDropdownState)
    }
    
    // Test the action on target currency selected of the view model
    func testOnTargetCurrencySelected() {
        let target: CurrencyValueModel = .init(
            code: "EUR",
            name: "Euro",
            value: 100,
            rate: 10.0
        )
        let convertedValue: Double = viewModel.baseCurrency.value * target.rate
        viewModel.onTargetCurrencySelected(to: target)
        
        XCTAssertEqual(viewModel.targetCurrency.code, target.code)
        XCTAssertEqual(viewModel.targetCurrency.name, target.name)
        XCTAssertEqual(viewModel.targetCurrency.value, convertedValue)
        XCTAssertEqual(viewModel.targetCurrency.rate, target.rate)
    }
}
