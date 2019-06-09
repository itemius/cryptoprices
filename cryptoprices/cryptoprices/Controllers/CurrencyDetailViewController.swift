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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fillCurrencyData()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func updateButtonAction(_ sender: Any) {
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
            self.currency = result
            self.fillCurrencyData()
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
