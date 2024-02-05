//
//  PokeAPI.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Alamofire

final class PokemonApi {
    
    func loadPokemon(completion: @escaping (Result<[Pokemon], Error>) -> ())  {
        
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=151").responseDecodable(of: PokemonList.self) { response in
            
            switch response.result {
            case .success(let pokemonList):
                completion(.success(pokemonList.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
