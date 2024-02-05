//
//  BaseAPIClient.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit
import Alamofire
import Combine
import SwiftUI

class BaseAPIClient {

    private var isReachable: Bool = true
    private var sesionManager: Alamofire.Session!

    private var baseURL: URL {

        if let url = URL(string: Environment<Any>.shared.baseURL) {
            return url
        } else {
            print("error.url.invalid".localized)
            return URL(string: "")!
        }
    }

    init() {

        // Control para el SSL pinning
//        let serverTrustPolicies: [String: ServerTrustEvaluating] = [
//            "api.myjson.com": PinnedCertificatesTrustEvaluator(),
//            ]
//
//        self.sesionManager = Session(
//            serverTrustManager: ServerTrustManager(evaluators: serverTrustPolicies)
//        )

        self.sesionManager = Session()
        startListenerReachability()
    }

    // MARK: - Public method

    func handler(error: Error?) -> BaseError? {

        if !self.isReachable { return BaseError.noInternetConnection }
        var baseError: BaseError?

        if error != nil {
            baseError = BaseError.generic
        }

        return baseError
    }
    
    func handleResponse<A: Codable>(success: @escaping (A) -> Void, failure: @escaping (BaseError) -> Void, dataResponse: AFDataResponse<A>) {
        
        if let baseError = self.handler(error: dataResponse.error) {
            failure(baseError)
            
        } else if let responseObject: A = dataResponse.value {
            success(responseObject)
            
        } else {
            failure(.generic)
        }
    }

    func request(_ relativePath: String?,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil) -> DataRequest {

        let urlAbsolute = baseURL.appendingPathComponent(relativePath!)
        return sesionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: URLEncoding.default)
    }

    func requestPublisher<T: Decodable>(relativePath: String?,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters? = nil, urlEncoding: JSONEncoding = .default, type: T.Type = T.self) -> AnyPublisher<T, BaseError> {

        let urlAbsolute = baseURL.appendingPathComponent(relativePath!)

        return sesionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: urlEncoding, headers: nil)
            .validate()
#if DEBUG
            .cURLDescription(on: .main, calling: { p in print(p) })
#endif
            .publishDecodable(type: T.self)
            .tryMap({ response in
                switch response.result {
                case let .success(result):
                    return result
                case let .failure(error):
                    throw error
                }
            })
            .mapError({ [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            })
            .eraseToAnyPublisher()
    }

    // MARK: - Private Method

    private func startListenerReachability() {

        let net = NetworkReachabilityManager()
        net?.startListening(onUpdatePerforming: {  status in
            if net?.isReachable ?? false {
                self.isReachable = true

            } else {
                self.isReachable = false
            }
        })
    }
}

