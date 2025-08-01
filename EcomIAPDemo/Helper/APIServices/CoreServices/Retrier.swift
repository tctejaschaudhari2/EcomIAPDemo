//
//  Retrier.swift
//  EcomIAPDemo
//
//  Created by tejas chaudhari on 27/07/25.
//

import Foundation
import Alamofire
import UIKit

typealias RetrierCompletion = (RetryResult) -> Void

// MARK: - NetworkRetrier

class NetworkRetrier: RequestRetrier {
    // MARK: Lifecycle

    init(limit: Int, delay: TimeInterval) {
        self.limit = limit
        self.delay = delay
    }

    // MARK: Internal

    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping RetrierCompletion) {
        guard request.retryCount < limit else {
            completion(.doNotRetry)
            return
        }
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        switch statusCode {
        case 401:
            // Refresh your token
            completion(.retry)
        default:
            completion(.retry)
        }
    }

    // MARK: Private

    private var limit: Int
    private var delay: TimeInterval
}

// MARK: - NetworkAdapter

class NetworkAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        completion(.success(adaptedRequest))
    }
}
