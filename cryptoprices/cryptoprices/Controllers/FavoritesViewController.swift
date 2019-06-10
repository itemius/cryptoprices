//
//  SecondViewController.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var currenciesList: [Currency] = [Currency]()
    var selectedCurrency: Currency = Currency()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadCurrencies()
    }

    func loadCurrencies() {
        self.currenciesList = DatabaseService.getCurrencies()
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCurrencyDetailFromFavorites" {
            if let destinationVC = segue.destination as? CurrencyDetailViewController {
                destinationVC.currency = self.selectedCurrency
            }
            self.selectedCurrency = Currency()
            self.currenciesList = [Currency]()
        }
    }
}

extension FavoritesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCurrency = currenciesList[indexPath.row]
        self.performSegue(withIdentifier: "showCurrencyDetailFromFavorites", sender: self)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyTableViewCell
        cell.label.text = currenciesList[indexPath.row].name
        return cell
    }
}

