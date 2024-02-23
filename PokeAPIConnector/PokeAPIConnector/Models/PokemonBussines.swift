//
//  PokemonBussines.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 15/2/24.
//

import Foundation
typealias PokemonBusiness = [PokemonName]

struct PokemonName: Codable, Comparable {
    let name: String
    
    init(from ability: Ability, combine: Bool) {
        self.name = combine ? ability.ability.name.uppercased() : ability.ability.name
    }

    static func < (lhs: PokemonName, rhs: PokemonName) -> Bool {
        lhs.name < rhs.name
    }
}
