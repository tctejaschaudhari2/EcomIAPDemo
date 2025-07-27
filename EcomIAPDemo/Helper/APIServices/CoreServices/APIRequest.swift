//
//  APIRequest.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 27/07/25.
//

import Foundation
import Alamofire
//import Swime

// MARK: - APIRequestProtocols

protocol APIRequestProtocols {
    func request<T: Codable>(_ endpoint: URLRequestConvertible, completion: @escaping (Result<T, AFError>) -> Void )
}

// MARK: - APIRequest

class APIRequest {
    // MARK: Lifecycle

    init() {
        let config = URLSessionConfiguration.af.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
        self.sessionManager = Session(configuration: config, interceptor: Interceptor(adapter: NetworkAdapter(), retrier: NetworkRetrier(limit: 2, delay: 30)))
    }
    
    deinit{
        debugPrint("APIRequest deinited")
    }

    // MARK: Private

    private var sessionManager: Session
    private let queue = DispatchQueue(label: "network-queue", qos: .userInitiated, attributes: .concurrent)
}

// MARK: APIRequestProtocols

extension APIRequest: APIRequestProtocols {
    func request<T>(_ endpoint: URLRequestConvertible, completion: @escaping (Result<T, Alamofire.AFError>) -> Void) where T : Decodable, T : Encodable {
        do {
            // Convert the endpoint to a URLRequest
            let urlRequest = try endpoint.asURLRequest()
            
            // Perform the request
            sessionManager.request(urlRequest)
                .validate()
                .responseDecodable(of: T.self, queue: queue) { response in
                    switch response.result {
                    case .success(let value):
                        self.queue.async {
                            completion(.success(value))
                        }
                    case .failure(let error):
                        self.queue.async {
                            completion(.failure(error))
                        }
                    }
                }
        } catch {
            // Handle URLRequest conversion failure
            self.queue.async {
                completion(.failure(AFError.createURLRequestFailed(error: error)))
            }
        }
    }

}
