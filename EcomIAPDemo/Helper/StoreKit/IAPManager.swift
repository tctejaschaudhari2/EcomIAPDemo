//
//  IAPManager.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 26/07/25.
//


import Foundation
import StoreKit

class IAPManager: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    static let shared = IAPManager()

    var products: [SKProduct] = []
    var handleTransaction: ((String) -> ())?
    private var productRequest: SKProductsRequest?

    override private init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    /// Fetch available products
    func fetchProducts(productIDs: [String]) {
        let productIdentifiers = Set(productIDs)
        productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest?.delegate = self
        productRequest?.start()
    }

    /// Start the purchase process
    func purchase(product: SKProduct) {
        guard SKPaymentQueue.canMakePayments() else {
            print("User cannot make payments.")
            return
        }
                
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }

    /// Restore previous purchases
    func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    /// Handle product request results
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.isEmpty {
            print("No products found.")
        } else {
            products = response.products
            for product in products {
                print("Product available: \(product.localizedTitle) - \(product.price)")
            }
        }
    }

    /// Handle purchase transactions
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("Purchase successful: \(transaction.payment.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
                handleTransaction?("success")
            case .restored:
                print("Purchase restored: \(transaction.payment.productIdentifier)")
                SKPaymentQueue.default().finishTransaction(transaction)
            case .failed:
                if let error = transaction.error {
                    print("Purchase failed: \(error.localizedDescription)")
                    handleTransaction?("failed")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            case .deferred:
                print("Purchase deferred.")
            case .purchasing:
                print("Purchase in progress.")
            @unknown default:
                break
            }
        }
    }
    
    /// Handle restored transactions
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("Restored transactions finished.")
    }
}
