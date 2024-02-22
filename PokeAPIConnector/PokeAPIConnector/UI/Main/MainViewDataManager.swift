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
    
    init(apiClient: MainAPIClient) {
        self.apiClient = apiClient
    }
    
    func getPokemonClosureNetwork(success: @escaping (Pokemon) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList { pokemon in
            print(pokemon)
            success(pokemon)
        } failure: { error in
            failure(error)
        }
        
    }
    
    func getPokemonClosureBussines(success: @escaping (PokemonBussiness) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList { pokemon in
            let pokemons = pokemon.abilities.map({ PokemonName(from: $0, combine: false) }).sorted()
            print(pokemons)
            success(pokemons)
        } failure: { error in
            failure(error)
        }
        
    }
    
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
    
    func getPokemonCombineBussines() -> AnyPublisher<PokemonBussiness, BaseError> {
        apiClient.getPokemonsListCombine()
            .tryMap { pokemons in
                return pokemons.abilities.map({ PokemonName(from: $0, combine: true) }).sorted()
            }
            .mapError { error in
                return error as? BaseError ?? BaseError.generic
            }
            .eraseToAnyPublisher()
    }
}
