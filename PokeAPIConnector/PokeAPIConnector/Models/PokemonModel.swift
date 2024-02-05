//
//  PokemonModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    
    let id: Int
    let attack: Int
    let name: String
    let imageUrl: String
}

