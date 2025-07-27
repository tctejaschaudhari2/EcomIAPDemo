//
//  ProductListingViewModel.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import Foundation
import Alamofire

class ProductListingViewModel: BaseViewModel {
    
    var showAlert: ((String?) -> ())?
    var nextScreen: ((String?, Int) -> ())?
    var loadList: (() -> ())?
    var products: [Product] = []
    
    init() {
        getProducts()
    }
    
    func getProducts(){
        NetworkManager.shared.productDetailsServices?.getProductDetails { (result: Result<[Product], AFError>) in
            switch result {
            case .success(let response):
                self.products = response
                if self.products.isEmpty {
                    self.showAlert?("No Products Found")
                } else {
                    self.updatePurchaseData()
                }
            case .failure(let error):
                self.showAlert?(error.localizedDescription)
            }
        }
    }
    
    func updatePurchaseData() {
        let purchasedProducts = UserDefaultsManager.shared.getPurchaseProductsData()
        products = products.map { product -> Product in
            var updatedProduct = product
            
            if let match = purchasedProducts?.first(where: {
                guard let pid = $0["productId"] as? String,
                      let purchased = $0["isPurchased"] as? Bool else {
                    return false
                }
                return pid == product.productId
            }) {
                updatedProduct.isPurchased = match["isPurchased"] as? Bool ?? false
            }
            
            return updatedProduct
        }
        self.loadList?()
    }
    
    func gotoNextScreen(productId: Int) {
        self.nextScreen?("", productId)
    }
    
}
