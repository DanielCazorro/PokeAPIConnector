//
//  MainAPIClient.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 15/2/24.
//

import Foundation
import Combine
import Alamofire

class MainAPIClient: BaseAPIClient {
    
    let pokemonurl = "pokemon/charmander"
    
    func getPokemonsList(success: @escaping (Pokemon) -> Void, failure: @escaping (BaseError) -> Void) {
        
        request(pokemonurl, method: .get, headers: [:], parameters: nil)
            .validate()
            .responseDecodable(of: Pokemon.self) { response in
                self.handleResponse(success: success, failure: failure, dataResponse: response)
            }
    }
    
    func getPokemonsListCombine() -> AnyPublisher<Pokemon, BaseError> {
        requestPublisher(relativePath: pokemonurl, method: .get, parameters: nil, urlEncoding: JSONEncoding.default, type: Pokemon.self)
    }
}
