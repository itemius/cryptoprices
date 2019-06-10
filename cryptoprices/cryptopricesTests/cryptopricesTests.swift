//
//  cryptopricesTests.swift
//  cryptopricesTests
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import XCTest
@testable import cryptoprices

class cryptopricesTests: XCTestCase {

    override func setUp() {
        DatabaseService.clearCurrencies()
    }

    override func tearDown() {
        DatabaseService.clearCurrencies()
    }

    func testAddToFavorites() {
        let currency = Currency()
        currency.id = "bitcoin"
        DatabaseService.addToFavorites(currency: currency)
        XCTAssertGreaterThan(DatabaseService.getCurrencies().count, 0)
    }

}
