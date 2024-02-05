//
//  PokemonModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

struct PokemonList: Decodable {
    
    let results: [Pokemon]
}

struct Pokemon: Decodable {
    
    let name: String
    let url: String
    
    var id: Int? {
        return Int(url.split(separator: "/").last?.description ?? "0")
    }
    
    var imageUrl: URL? {
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id ?? 0).png")
    }
}

