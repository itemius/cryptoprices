//
//  FirstViewController.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

class CurrenciesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var currenciesList: [Currency] = [Currency]()
    var selectedCurrency: Currency = Currency()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.delegate = self
        tableView.dataSource = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshCurrenciesData(_:)), for: .valueChanged)

        tableView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadCurrencies()
    }

    @objc private func refreshCurrenciesData(_ sender: Any) {
        loadCurrencies()
    }

    func loadCurrencies() {
        ApiDataService.getCurrencies { response in
            switch response.result {
            case .success :
                if let resultValue = response.result.value {
                    let json = JSON(resultValue)
                    if let currencies = json.array {
                        for currency in currencies {
                            let currencyModel = self.parseCurrencyModel(currency: currency)
                            self.currenciesList.append(currencyModel)
                        }
                        self.tableView.reloadData()
                        self.tableView.refreshControl?.endRefreshing()
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }

    func parseCurrencyModel(currency: JSON) -> Currency {
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCurrencyDetail" {
            if let destinationVC = segue.destination as? CurrencyDetailViewController {
                destinationVC.currency = self.selectedCurrency
            }
        }
    }

}

extension CurrenciesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCurrency = currenciesList[indexPath.row]
        self.performSegue(withIdentifier: "showCurrencyDetail", sender: self)
    }
}

extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyTableViewCell
        cell.label.text = currenciesList[indexPath.row].name
        return cell

    }


}

