//
//  Currency.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import Foundation

class Currency {

    var name: String
    var symbol: String
    var priceUSD: Double
    var priceBTC: Double

    init(name: String, symbol: String, priceUSD: Double, priceBTC: Double) {
        self.name = name
        self.symbol = symbol
        self.priceUSD = priceUSD
        self.priceBTC = priceBTC
    }
}
