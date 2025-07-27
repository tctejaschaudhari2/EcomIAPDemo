//
//  ProductDetailViewModel.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import Foundation

class ProductDetailViewModel: BaseViewModel {
    
    var showAlert: ((String?) -> ())?
    var nextScreen: ((String?, Int) -> ())?
    var updateUI: (() -> ())?
    
    var product : Product?
    
    var productId : [String] = ["clothes.classic_red_baseball_cap",
                                "clothes.classic_comfort_fit_joggers",
                                "clothes.classic_olive_chino_shorts",
                                "clothes.classic_high_waisted_athletic_shorts",
                                "clothes.classic_white_crew_neck_t_shirt"]
    
    init(product: Product) {
        self.product = product
    }
    
    func initIAP() {
        IAPManager.shared.fetchProducts(productIDs: productId)
    }
    
    func buyProduct(productId: String) {
        if let product = IAPManager.shared.products.first(where: { $0.productIdentifier == productId }) {
            IAPManager.shared.purchase(product: product)
            IAPManager.shared.handleTransaction = { [weak self] (transaction) in
                switch transaction{
                case "failed":
                    self?.showAlert?("transaction failed!! Cancelled by user or insufficeint balance")
                case "success":
                    self?.updateUI?()
                    let productStatus = ["productId": "\(productId)", "isPurchased": true]
                    var purchasedProductData = UserDefaultsManager.shared.getPurchaseProductsData()
                    purchasedProductData?.append(productStatus)
                    UserDefaultsManager.shared.setPurchaseProductsData(products: purchasedProductData ?? [])
                default:
                    break
                }
            }
        } else {
            showAlert?("Product not found")
        }
    }
}
