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
    
    // URL base para la API de Pokemon
    let baseURL = "https://pokeapi.co/api/v2/"
    
    // Endpoint para obtener la lista de pokemons (en este caso, solo se está obteniendo información de Charmander)
    let pokemonURL = "pokemon/charmander"
    
    // Método para obtener la lista de pokemons usando callbacks
    func getPokemonsList(success: @escaping (Pokemon) -> Void, failure: @escaping (BaseError) -> Void) {
        // Realizamos una solicitud GET a la URL especificada
        request(baseURL + pokemonURL, method: .get, headers: [:], parameters: nil)
            // Validamos la respuesta
            .validate()
            // Decodificamos la respuesta en un objeto de tipo Pokemon
            .responseDecodable(of: Pokemon.self) { response in
                // Manejamos la respuesta llamando a la función handleResponse
                self.handleResponse(success: success, failure: failure, dataResponse: response)
            }
    }
    
    // Método para obtener la lista de pokemons usando Combine
    func getPokemonsListCombine() -> AnyPublisher<Pokemon, BaseError> {
        // Utilizamos el método requestPublisher de BaseAPIClient para obtener un publisher de tipo AnyPublisher<Pokemon, BaseError>
        requestPublisher(relativePath: pokemonURL, method: .get, parameters: nil, urlEncoding: JSONEncoding.default, type: Pokemon.self)
    }
}
