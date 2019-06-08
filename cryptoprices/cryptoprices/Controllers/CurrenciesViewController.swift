//
//  FirstViewController.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import UIKit

class CurrenciesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var currenciesList: [Currency] = [Currency]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
        tableView.delegate = self
        tableView.dataSource = self
    }

}

extension CurrenciesViewController: UITableViewDelegate {

}

extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyTableViewCell

        return cell

    }


}

