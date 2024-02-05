//
//  MainViewControllerDataManager.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

class MainViewControllerDataManager {
    
}

protocol PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon])
}


struct PokemonManager {
    var delegate: PokemonManagerDelegate?
    
    func seePokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("Error al obtener datos de la API: ",error?.localizedDescription)
                }
                
                if let secureData = data?.parseData(takeOffString: "null,"){
                    if let pokemonList = self.parsearJson(pokemonData: secureData) {
                        print("Lista pokemon: ",pokemonList)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parsearJson(pokemonData: Data) -> [Pokemon]? {
        let decodificater = JSONDecoder()
        do {
            let decodificatedData = try decodificater.decode([Pokemon].self, from: pokemonData)
            
            return decodificatedData
        } catch {
            print("Error al decodificar los datos: ", error.localizedDescription)
            return nil
        }
    }
}


extension Data {
    func parseData(takeOffString word: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: word, with: "")
        guard let data = parseDataString?.data(using: .utf8) else { return nil }
        return data
    }
}
