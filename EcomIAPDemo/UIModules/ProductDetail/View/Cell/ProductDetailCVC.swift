//
//  ProductDetailCVC.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import UIKit
import AlamofireImage

class ProductDetailCVC: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    static let identifier = "ProductDetailCVC"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func loadFromNib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func loadImage(imgUrlString: String){
        if let imgURL = URL(string: imgUrlString) {
//            img.image = nil
            img.af.setImage(withURL: imgURL)
        }
    }


}
