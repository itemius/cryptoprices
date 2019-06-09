//
//  CurrencyService.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 09/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import Foundation
import SwiftyJSON

class CurrencyService {

    static func getCurrencies(completion: @escaping ([Currency]) -> Void) {
        ApiDataService.getCurrencies { response in
            switch response.result {
            case .success :
                if let resultValue = response.result.value {
                    let json = JSON(resultValue)
                    var currenciesList = [Currency]()
                    if let currencies = json.array {
                        for currency in currencies {
                            let currencyModel = self.parseCurrencyModel(currency: currency)
                            currenciesList.append(currencyModel)
                        }
                        completion(currenciesList)
                    }
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }

    static func getCurrencyDetail(id: String, completion: @escaping (Currency) -> Void) {
        ApiDataService.getCurrencyDetail(id: id) { response in
            switch response.result {
            case .success :
                if let resultValue = response.result.value {
                    let json = JSON(resultValue)
                    let currencyModel = self.parseCurrencyModel(currency: (json.array?.first)!)
                    completion(currencyModel)
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }

    private static func parseCurrencyModel(currency: JSON) -> Currency {
        let currencyModel = Currency()
        if let id = currency["id"].string {
            currencyModel.id = id
        }

        if let name = currency["name"].string {
            currencyModel.name = name
        }

        if let symbol = currency["symbol"].string {
            currencyModel.symbol = symbol
        }

        if let priceUSD = currency["price_usd"].string {
            currencyModel.priceUSD = priceUSD
        }

        if let priceBTC = currency["price_btc"].string {
            currencyModel.priceBTC = priceBTC
        }

        return currencyModel
    }

    
}
