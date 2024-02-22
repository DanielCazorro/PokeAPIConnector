//
//  MainViewControllerDataManager.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

class MainViewDataManager {
    private var apiClient: MainAPIClient
    
    init(apiClient: MainAPIClient) {
        self.apiClient = apiClient
    }
    
    func getPokemonClosureNetwork(success: @escaping (Pokemon1) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList { pokemon in
            print(pokemon)
            success(pokemon)
        } failure: { error in
            failure(error)
        }

    }
    
    func getPokemonClosureBussines(success: @escaping (PokemonBussiness) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList { pokemon in
            let pokemons = pokemon.abilities.map({ PokemonName(from: $0) }).sorted()
            print(pokemons)
            success(pokemons)
        } failure: { error in
            failure(error)
        }
    }
    
    func getPokemonList(success: @escaping (Pokemon1) -> Void, failure: @escaping (BaseError) -> Void) {
        apiClient.getPokemonsList(success: success, failure: failure)
    }
    
}
/*

    func fetchPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching Pokémon data:", error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received when fetching Pokémon")
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            // Print the raw data received from the API
            if let dataString = String(data: data, encoding: .utf8) {
                print("Raw Pokémon data:", dataString)
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([Pokemon?].self, from: data)
                let filteredData = decodedData.compactMap { $0 }
                completion(.success(filteredData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}



struct PokemonManager {
    var delegate: PokemonManagerDelegate?
    
    func seePokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener datos de la API: ", error?.localizedDescription ?? "ERROR")
                    return
                }
                
                if let secureData = data?.parseData(takeOffString: "null,") {
                    if let pokemonList = self.parsearJson(pokemonData: secureData) {
                        print("Lista pokemon: ", pokemonList)
                        delegate?.showListPokemon(list: pokemonList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parsearJson(pokemonData: Data) -> [Pokemon]? {
        do {
            let decodificater = JSONDecoder()
            let decodificatedData = try decodificater.decode([Pokemon].self, from: pokemonData)
            return decodificatedData
        } catch {
            print("Error al decodificar los datos: ", error.localizedDescription)
            return nil
        }
    }
    
}

protocol PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon])
}

extension Data {
    func parseData(takeOffString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
*/
