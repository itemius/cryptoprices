//
//  UIViewControllerExtension.swift
//  cryptoprices
//
//  Created by Artem Izyumov on 10/06/2019.
//  Copyright © 2019 itemius. All rights reserved.
//

import UIKit

extension UIViewController {

    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }

}
