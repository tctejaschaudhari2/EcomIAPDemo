//
//  ProductDetailServicesProtocols.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 27/07/25.
//


import Foundation
import Alamofire

// MARK: - ProductDetailServicesProtocols

protocol ProductDetailServicesProtocols {
    func getProductDetails(completion: @escaping (Result<[Product], AFError>) -> Void )
}

// MARK: - ProductDetailServices

class ProductDetailServices {
    // MARK: Lifecycle

    init(apiRequest: APIRequest) {
        self.apiRequest = apiRequest
    }

    deinit {
        debugPrint("ProductDetail service deinited")
    }

    // MARK: Private

    private var apiRequest: APIRequest
}

// MARK: Using ProductDetailServicesProtocols

extension ProductDetailServices: ProductDetailServicesProtocols {
    func getProductDetails(completion: @escaping (Result<[Product], Alamofire.AFError>) -> Void) {
        self.apiRequest.request(ProductDetailRouter.getProductDetails) { (result: Result<[Product], AFError>) in
            switch result {
            case .success(let resp):
                completion(.success(resp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
    
extension ProductDetailServices {
    enum ProductDetailRouter: NetworkRouter {
        case getProductDetails

        // MARK: Internal

        var baseURLString: String {
            return APIURL.kProductDetailURL
        }

        var path: String {
            let path =  APIConstant.kProduct
            return path
        }
        
        var headers: [String: String]? {
            return RequestHeaderBuilder.shared
                .addAcceptEncodingHeaders(type: .gzip)
                .addAcceptHeaders(type: .applicationJson)
                .addConnectionHeader(type: .keepAlive)
                .addContentTypeHeader(type: .applicationJsonUTF8)
                .build()
        }

        var method: RequestMethod? {
            return .get
        }

        var encoding: ParameterEncoding? {
            return JSONEncoding.default
        }

    }
}
