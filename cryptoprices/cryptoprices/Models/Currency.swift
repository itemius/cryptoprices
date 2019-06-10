//
//  Currency.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import Foundation
import RealmSwift

class Currency: Object {

    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var priceUSD: String = ""
    @objc dynamic var priceBTC: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

}
