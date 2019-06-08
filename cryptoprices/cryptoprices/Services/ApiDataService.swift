//
//  ApiDataService.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

// MARK: - Basic Setup -

class ApiDataService {
    static let endpoint = "https://api.coinmarketcap.com/v1/"
    static let manager = SessionManager(configuration: ApiDataService.configuration())

    static func configuration() -> URLSessionConfiguration {
        let configuration = SessionManager.default.session.configuration
        configuration.timeoutIntervalForRequest = 20
        configuration.httpAdditionalHeaders = ["Accept": "application/json"]
        return configuration
    }

    static func getCurrencies(completion: @escaping (DataResponse<Any>) -> Void) {
        manager.request(self.endpoint + "/ticker", method: .get).responseJSON(completionHandler: completion)
    }
    
    static func getCurrencyDetail(id: String, completion: @escaping (DataResponse<Any>) ->
        Void) {
        manager.request(self.endpoint + "/ticker/\(id)", method: .get).responseJSON(completionHandler: completion)
    }
}
