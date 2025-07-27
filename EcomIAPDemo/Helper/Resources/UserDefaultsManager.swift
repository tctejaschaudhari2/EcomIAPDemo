//
//  UserDefaultsManager.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 27/07/25.
//

import Foundation
import UIKit

class UserDefaultsManager: NSObject {
    
    static let shared = UserDefaultsManager()
    
    func setPurchaseProductsData(products: [[String: Any]]) {
        UserDefaults.standard.set(products, forKey: "purchasedProduct")
        UserDefaults.standard.synchronize()
    }
    
    func getPurchaseProductsData() -> [[String: Any]]? {
        if let purchaseProducts = UserDefaults.standard.array(forKey: "purchasedProduct") as? [[String: Any]]? {
            return purchaseProducts
        } else {
            return []
        }
    }
    
}
