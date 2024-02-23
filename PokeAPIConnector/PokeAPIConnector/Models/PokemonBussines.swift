//
//  PokemonBussines.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 15/2/24.
//

import Foundation

// Definición de un alias para el tipo PokemonBusiness
typealias PokemonBusiness = [PokemonName]

// Definición de la estructura PokemonName, que representa una habilidad de un Pokemon
struct PokemonName: Codable, Comparable {
    let name: String  // Nombre de la habilidad
    
    // Inicializador que toma una Ability y un indicador booleano para indicar si la habilidad proviene de una solicitud combinada
    init(from ability: Ability, combine: Bool) {
        self.name = combine ? ability.ability.name.uppercased() : ability.ability.name
    }

    // Método estático para comparar dos objetos PokemonName
    static func < (lhs: PokemonName, rhs: PokemonName) -> Bool {
        lhs.name < rhs.name
    }
}
