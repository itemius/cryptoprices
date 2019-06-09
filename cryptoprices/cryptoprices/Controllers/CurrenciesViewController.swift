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

        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadCurrencies()
    }

    @objc private func refreshCurrenciesData(_ sender: Any) {
        loadCurrencies()
    }

    @objc func updateData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadCurrencies()
    }

    func loadCurrencies() {
        CurrencyService.getCurrencies { result in
            self.currenciesList = result
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
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

