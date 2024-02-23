//
//  MainViewControllerDataManager.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation
import Combine

class MainViewDataManager {
    private var apiClient: MainAPIClient
    
    // Inicializador que recibe un MainAPIClient
    init(apiClient: MainAPIClient) {
        self.apiClient = apiClient
    }
    
    // Método para obtener la lista de pokemons usando callbacks y manejarlos en la capa de red
    func getPokemonClosureNetwork(success: @escaping (Pokemon) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList(success: success, failure: failure)
    }
    
    // Método para obtener la lista de pokemons usando callbacks y manejarlos en la capa de negocio
    func getPokemonClosureBusiness(success: @escaping (PokemonBusiness) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList { pokemon in
            // Convertimos los datos recibidos en Pokemon a PokemonBusiness según la lógica de negocio
            let pokemons = pokemon.abilities.map({ PokemonName(from: $0, combine: false) }).sorted()
            print(pokemons)
            success(pokemons)
        } failure: { error in
            failure(error)
        }
    }
    
    // Método para obtener la lista de pokemons usando Combine y manejarlos en la capa de red
    func getPokemonCombineNetwork() -> AnyPublisher<Pokemon, BaseError> {
        apiClient.getPokemonsListCombine()
            .tryMap { pokemons in
                return pokemons
            }
            .mapError { error in
                return error as? BaseError ?? BaseError.generic
            }
            .eraseToAnyPublisher()
    }
    
    // Método para obtener la lista de pokemons usando Combine y manejarlos en la capa de negocio
    func getPokemonCombineBusiness() -> AnyPublisher<PokemonBusiness, BaseError> {
        apiClient.getPokemonsListCombine()
            .tryMap { pokemons in
                // Convertimos los datos recibidos en Pokemon a PokemonBusiness según la lógica de negocio
                return pokemons.abilities.map({ PokemonName(from: $0, combine: true) }).sorted()
            }
            .mapError { error in
                return error as? BaseError ?? BaseError.generic
            }
            .eraseToAnyPublisher()
    }
}
