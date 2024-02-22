//
//  BaseAPIClient.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit
import Alamofire

class BaseAPIClient {

    private var isReachable: Bool = true
    private var sesionManager: Alamofire.Session!

    private var baseURL: URL {

        if let url = URL(string: "https://pokeapi.co/api/v2/") {
            return url
        } else {
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
        
        if let baseError = self.handler(error: dataResponse.error)  {
            failure(baseError)
            
        } else if let responseObject: A = dataResponse.value {
            success(responseObject)
            
        } else {
            failure(.generic)
        }
    }

    func request(_ relativePath: String?,
                 method: HTTPMethod = .get,headers: [String: String] = [:],
                 parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {

        let urlAbsolute = baseURL.appendingPathComponent(relativePath!)
        return sesionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: encoding, headers: HTTPHeaders(headers)).cURLDescription { p in
             print(p)
        }
        
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
