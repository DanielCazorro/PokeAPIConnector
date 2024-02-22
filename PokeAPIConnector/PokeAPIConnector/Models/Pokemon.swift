//
//  PokemonModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

struct Pokemon: Codable {
    let abilities: [Ability]
}

struct Ability: Codable {
    let ability: AbilityName
    let is_hidden: Bool
    let slot: Int
}

struct AbilityName: Codable {
    let name, url: String
}
