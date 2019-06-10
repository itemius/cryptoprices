//
//  CurrencyDetailViewController.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 08/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import UIKit
import MBProgressHUD

class CurrencyDetailViewController: UIViewController {

    var currency: Currency = Currency()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var priceBTCLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillCurrencyData()
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)

        if DatabaseService.checkIsFavorited(currency: self.currency) {
            favoritesButton.setTitle("Remove from favorites", for: .normal)
        }
        else {
            favoritesButton.setTitle("Add to favorites", for: .normal)
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func updateButtonAction(_ sender: Any) {
        updateData()
    }

    @IBAction func favoritesButtonAction(_ sender: Any) {
        if DatabaseService.checkIsFavorited(currency: self.currency) {
            DatabaseService.removeFromFavorites(currency: self.currency)
            self.currency = Currency()
            favoritesButton.setTitle("Add to favorites", for: .normal)
        }
        else {
            DatabaseService.addToFavorites(currency: self.currency)
            favoritesButton.setTitle("Remove from favorites", for: .normal)
        }
    }

    @objc func updateData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.loadCurrencyDetail()
    }

    func fillCurrencyData() {
        nameLabel.text = currency.name
        symbolLabel.text = currency.symbol
        priceUSDLabel.text = currency.priceUSD
        priceBTCLabel.text = currency.priceBTC
    }

    func loadCurrencyDetail() {
        CurrencyService.getCurrencyDetail(id: currency.id) { result in
            if let currency = result {
                self.currency = currency
                self.fillCurrencyData()
            }
            else {
                self.showErrorAlert("Error loading data")
            }
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
