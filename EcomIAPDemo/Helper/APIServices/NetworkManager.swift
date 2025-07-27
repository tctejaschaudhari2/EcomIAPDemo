//
//  NetworkManager.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 27/07/25.
//


import Foundation

class NetworkManager {
    // MARK: Lifecycle

    private init() {}

    deinit {
        debugPrint("NetworkManager deinited")
    }

    // MARK: Internal

    class var shared: NetworkManager {
        guard let sharedInstance else {
            let instance = NetworkManager()
            sharedInstance = instance
            return sharedInstance ?? .init()
        }
        return sharedInstance
    }

    lazy var productDetailsServices: ProductDetailServices? = .init(apiRequest: self.apiRequest)

    class func destroy() {
        sharedInstance = nil
    }

    // MARK: Private

    private static var sharedInstance: NetworkManager?

    private lazy var apiRequest: APIRequest = .init()
}
