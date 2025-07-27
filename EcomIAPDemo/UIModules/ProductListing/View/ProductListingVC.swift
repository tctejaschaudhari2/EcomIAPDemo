//
//  ProductListingVC.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//

import UIKit

class ProductListingVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var productListingVM: ProductListingViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        productListingVM = ProductListingViewModel()
        initCurrentScreen()
        self.collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNib()
        initCurrentScreen()
    }
    
    func loadNib(){
        self.collectionView.register(ProductListingCVC.loadFromNib(), forCellWithReuseIdentifier: ProductListingCVC.identifier)
    }

    func initCurrentScreen() {
        
        productListingVM?.showAlert = { [weak self] (message) in
            DispatchQueue.main.async {
                self?.showAlertDialog(message: message)
            }
        }
        
        productListingVM?.loadList = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        productListingVM?.nextScreen = { [weak self] (str, idx) in
            
            DispatchQueue.main.async {
                let vc = UIStoryboard(name: "Main", bundle : nil).instantiateViewController(withIdentifier: "ProductDetailVC") as! ProductDetailVC
                vc.modalPresentationStyle = .fullScreen
                vc.delegate = self
                guard let selectedProduct = self?.productListingVM?.products[idx] else { return }
                let productDetailVM = ProductDetailViewModel(product: selectedProduct)
                vc.productDetailVM = productDetailVM
                self?.present(vc, animated: true)
            }
        }

    }
}

extension ProductListingVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListingVM?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let unwrappedCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListingCVC.identifier, for: indexPath) as? ProductListingCVC else {
            return UICollectionViewCell()
        }
        unwrappedCell.productData = productListingVM?.products[indexPath.row]
        
        return unwrappedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let wd : Double = ((collectionView.frame.width / 2.0))
        let ht : Double = wd * 5/3

    
        return CGSize(width: wd, height: ht)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productListingVM?.gotoNextScreen(productId: indexPath.row)
    }
    

}

extension ProductListingVC: actionDelegate {
    func action() {
        productListingVM?.getProducts()
    }
}
