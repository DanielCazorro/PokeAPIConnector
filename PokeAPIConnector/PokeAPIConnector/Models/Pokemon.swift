//
//  PokemonModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

// Estructura que representa un Pokemon
struct Pokemon: Codable {
    let name: String  // Nombre del Pokemon
    let abilities: [Ability]  // Habilidades del Pokemon
}

// Estructura que representa una habilidad de un Pokemon
struct Ability: Codable {
    let ability: AbilityName  // Nombre de la habilidad
    let is_hidden: Bool  // Indica si la habilidad está oculta
    let slot: Int  // Ranura de la habilidad
}

// Estructura que representa el nombre de una habilidad
struct AbilityName: Codable {
    let name, url: String  // Nombre y URL de la habilidad
}
