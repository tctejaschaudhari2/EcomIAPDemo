//
//  ProductListingCVC.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import UIKit
import AlamofireImage

class ProductListingCVC: UICollectionViewCell {
    
    @IBOutlet weak var imgProductImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductCost: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    static let identifier = "ProductListingCVC"
    
    var productData: Product? {
        didSet {
            guard let productData = productData else { return }
            lblProductName.text = productData.title
            lblProductCost.text = "$ \(productData.price ?? 0)"
            if let imgURL = URL(string: productData.images?.first ?? "") {
                imgProductImage.af.setImage(withURL: imgURL)
            }
            
            if productData.isPurchased {
                self.btnBuy.setTitle("Purchased", for: .normal)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func loadFromNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

}
