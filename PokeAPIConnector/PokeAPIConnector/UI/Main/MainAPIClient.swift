//
//  MainAPIClient.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 15/2/24.
//

import Foundation

class MainAPIClient: BaseAPIClient {
    
    let pokemonurl = "pokemon/charmander"
    let pokemonListUrl = "pokemon?limit=1000" // URL para obtener la lista de todos los Pokémon

    func getPokemonsList(success: @escaping (Pokemon) -> Void, failure: @escaping (BaseError) -> Void) {
        
        request(pokemonListUrl, method: .get, headers: [:], parameters: nil)
            .validate()
            .responseDecodable(of: Pokemon.self) { response in
                self.handleResponse(success: success, failure: failure, dataResponse: response)
            }
    }
}
