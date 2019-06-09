//
//  DatabaseService.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 09/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseService {

    static func checkIsFavorited(currency: Currency) -> Bool {
        let realm = try! Realm()

        if let _ = realm.object(ofType: Currency.self, forPrimaryKey: currency.id)  {
            return true
        }
        else {
            return false
        }
    }

    static func addToFavorites(currency: Currency) {
        let realm = try! Realm()
        realm.beginWrite()
        realm.add(currency, update: true)
        try! realm.commitWrite()
    }

    static func removeFromFavorites(currency: Currency) {
        let realm = try! Realm()
        if let removingCurrency = realm.object(ofType: Currency.self, forPrimaryKey: currency.id)  {
            realm.beginWrite()
            realm.delete(removingCurrency)
            try! realm.commitWrite()
        }
        else {
        }
    }

    static func getCurrencies() -> [Currency] {
        let realm = try! Realm()
        let currencies = Array(realm.objects(Currency.self))
        return currencies
    }
}
