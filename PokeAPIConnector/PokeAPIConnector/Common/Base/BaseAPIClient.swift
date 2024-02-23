//
//  BaseAPIClient.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit
import Alamofire
import Combine

class BaseAPIClient {
    
    // MARK: - Properties
    
    private var isReachable: Bool = true
    private var sessionManager: Alamofire.Session!
    
    private var baseURL: URL {
        // URL base de la API
        if let url = URL(string: "https://pokeapi.co/api/v2/") {
            return url
        } else {
            return URL(string: "")!
        }
    }
    
    // MARK: - Initialization
    
    init() {
        // Inicialización del SessionManager de Alamofire y configuración del listener de conectividad
        self.sessionManager = Session()
        startListenerReachability()
    }
    
    // MARK: - Public Methods
    
    // Método para manejar los errores de la API
    func handler(error: Error?) -> BaseError? {
        // Comprueba si hay conexión a Internet
        if !self.isReachable {
            return BaseError.noInternetConnection
        }
        
        // Comprueba si hay un error genérico
        if error != nil {
            return BaseError.generic
        }
        
        return nil
    }
    
    // Método para manejar la respuesta de la API
    func handleResponse<A: Codable>(success: @escaping (A) -> Void, failure: @escaping (BaseError) -> Void, dataResponse: AFDataResponse<A>) {
        // Manejar los errores de la API
        if let baseError = self.handler(error: dataResponse.error) {
            failure(baseError)
        } else if let responseObject: A = dataResponse.value {
            success(responseObject)
        } else {
            failure(.generic)
        }
    }
    
    // Método para realizar una solicitud a la API
    func request(_ relativePath: String?, method: HTTPMethod = .get, headers: [String: String] = [:], parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> DataRequest {
        let urlAbsolute = baseURL.appendingPathComponent(relativePath!)
        return sessionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: encoding, headers: HTTPHeaders(headers)).cURLDescription { p in
            print(p)
        }
    }
    
    // Método para realizar una solicitud a la API usando Combine
    func requestPublisher<T: Decodable>(relativePath: String?, method: HTTPMethod = .get, parameters: Parameters? = nil, urlEncoding: ParameterEncoding = JSONEncoding.default, type: T.Type = T.self, base: URL? = URL(string: "https://pokeapi.co/api/v2/"), customHeaders: HTTPHeaders? = nil) -> AnyPublisher<T, BaseError> {
        guard let url = base, let path = relativePath else {
            return Fail(error: BaseError.generic).eraseToAnyPublisher()
        }
        
        guard let urlAbsolute = url.appendingPathComponent(path).absoluteString.removingPercentEncoding else {
            return Fail(error: BaseError.generic).eraseToAnyPublisher()
        }
        
        return sessionManager.request(urlAbsolute, method: method, parameters: parameters, encoding: urlEncoding, headers: nil)
            .validate()
#if DEBUG
            .cURLDescription(on: .main, calling: { p in print(p) })
#endif
            .publishDecodable(type: T.self, emptyResponseCodes: [204])
            .tryMap { response in
                switch response.result {
                case let .success(result):
                    return result
                case let .failure(error):
                    return error as! T
                }
            }
            .mapError { [weak self] error in
                guard let self = self else { return .generic }
                return self.handler(error: error) ?? .generic
            }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    
    // Método para iniciar el listener de conectividad
    private func startListenerReachability() {
        let networkReachability = NetworkReachabilityManager()
        networkReachability?.startListening(onUpdatePerforming: { status in
            if networkReachability?.isReachable ?? false {
                self.isReachable = true
            } else {
                self.isReachable = false
            }
        })
    }
}
