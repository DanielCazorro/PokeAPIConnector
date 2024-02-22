//
//  PokemonBussines.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 15/2/24.
//

import Foundation
typealias PokemonBussiness = [PokemonName]

struct PokemonName: Codable, Comparable {
    let name: String
    
    init(from ability: Ability) {
        self.name = ability.ability.name
    }
    
    static func < (lhs: PokemonName, rhs: PokemonName) -> Bool {
        lhs.name < rhs.name
    }
}
