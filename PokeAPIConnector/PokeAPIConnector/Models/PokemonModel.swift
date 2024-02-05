//
//  PokemonModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit

struct Pokemon: Codable {
    let base_experience: Int
    let height: Int
    let weight: Int
    let id: Int
    let name: String
    let types: [PokeType]?
    let sprites: Sprites?
    let stats: [Stats]
    let abilities: [SingleAbility]
    let moves: [SelfMove]
    
    enum CodingKeys: CodingKey {
        case base_experience
        case height
        case weight
        case id
        case name
        case types
        case sprites
        case stats
        case abilities
        case moves
    }
}

struct PokeType: Codable {
    let slot: Int
    let type: PType?
    
    enum CodingKeys: CodingKey {
        case slot
        case type
    }
}

struct PType: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

struct Stats: Codable {
    let base_stat: Int
    let effort: Int
    let stat: Stat
    
    enum CodingKeys: CodingKey {
        case base_stat
        case effort
        case stat
    }
}

struct Stat: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    
}

struct Sprites: Codable {
    let front_default: String
    let back_default: String
    let other: Other
    
    enum CodingKeys: CodingKey {
        case front_default
        case other
        case back_default
    }
}

struct Other : Codable {
    let officialArtwork: OfficialArtwork
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let front_default: String
    let front_shiny: String
    
    enum CodingKeys: CodingKey {
        case front_default
        case front_shiny
    }
}

struct SingleAbility: Codable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
    
    enum CodingKeys: CodingKey {
        case ability
        case is_hidden
        case slot
    }
}

struct Ability: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

struct Moves: Codable {
    let move: SelfMove
    
    enum CodingKeys: CodingKey {
        case move
    }
}

struct SelfMove: Codable {
    let move: Move
    
    enum CodingKeys: CodingKey {
        case move
    }
}

struct Move: Codable {
    let name: String
    let url: String
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
}

