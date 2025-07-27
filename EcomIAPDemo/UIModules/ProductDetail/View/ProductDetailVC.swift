//
//  ProductDetailVC.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductCost: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    @IBOutlet weak var vewBuy: UIView!
    @IBOutlet weak var vewPurchase: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productDetailVM: ProductDetailViewModel!
    var delegate: actionDelegate? = nil
        
    override func viewDidLoad() {
        super.viewDidLoad()
        initCurrentScreen()
        // Do any additional setup after loading the view.
    }
    
    func initCurrentScreen() {
        
        productDetailVM?.showAlert = { [weak self] (message) in
            DispatchQueue.main.async {
                self?.showAlertDialog(message: message)
            }
        }
        
        productDetailVM?.updateUI = {
            self.updateUI()
        }
        
        productDetailVM?.nextScreen = { (str, idx) in
        }
        

    }

    
    override func viewWillAppear(_ animated: Bool) {
        initCurrentScreen()
        loadNib()
        loadUIData()
        productDetailVM.initIAP()
        
    }
    
    func loadNib(){
        self.collectionView.register(ProductDetailCVC.loadFromNib(), forCellWithReuseIdentifier: ProductDetailCVC.identifier)
    }
    
    func loadUIData() {
        DispatchQueue.main.async {
            self.lblProductName.text = self.productDetailVM?.product?.title
            self.lblProductCost.text = "$ \(self.productDetailVM?.product?.price ?? 0)"
            self.lblProductDescription.text = self.productDetailVM?.product?.description
            self.collectionView.reloadData()
            if self.productDetailVM?.product?.isPurchased ?? false {
                self.vewBuy.isHidden = true
                self.vewPurchase.isHidden = false
            }
        }
    }
    
    func updateUI() {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.vewBuy.isHidden = true
            self.vewPurchase.isHidden = false
        })
    }
    
    @IBAction func buyAct(_ sender: UIButton) {
        
        if sender.tag == 0 {
            self.dismiss(animated: true){
                self.delegate?.action()
            }
        } else {
            self.productDetailVM.buyProduct(productId: productDetailVM.product?.productId ?? "")
        }
    }
    

}

extension ProductDetailVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDetailVM?.product?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCVC.identifier, for: indexPath) as? ProductDetailCVC else {
            return UICollectionViewCell()
        }
        
        unwrappedCell.loadImage(imgUrlString: productDetailVM?.product?.images?[indexPath.row] ?? "")
        
        return unwrappedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let wd : Double = ((collectionView.frame.width) - 10.0)
    
        return CGSize(width: wd, height: wd)
    }

}
