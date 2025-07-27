//
//  UIViewController+Extensions.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlertDialog(title: String? = "Alert!", message : String?){
        let alrt = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Dismiss", style: .cancel)
        alrt.addAction(cancel)
        self.present(alrt, animated: true, completion: nil)
    }
}
