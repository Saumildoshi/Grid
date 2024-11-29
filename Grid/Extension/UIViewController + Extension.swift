//
//  UIViewController + Extension.swift
//  TatvaSoft_Saumil_Doshi
//
//  Created by Saumil Doshi on 25/11/24.
//

import UIKit

extension UIViewController {

    func showAlert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
