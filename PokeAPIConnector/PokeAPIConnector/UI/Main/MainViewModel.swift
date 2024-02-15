//
//  MainViewModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

class MainViewModel {
    
    private var dataManager: MainViewDataManager
    
    // Array observable para almacenar la lista de Pokémon y notificar cambios a la vista
    var pokemons: [Pokemon] = [] {
        didSet {
            // Notificar a la vista cuando cambia la lista de Pokémon
            pokemonsDidChange?(pokemons)
        }
    }
    
    // Closure para notificar a la vista cuando cambia la lista de Pokémon
    var pokemonsDidChange: (([Pokemon]) -> Void)?

    init(dataManager: MainViewDataManager) {
        self.dataManager = dataManager
    }
    
    
    // Método para cargar la lista de Pokémon desde el data manager

    func fetchPokemons() {
        dataManager.fetchPokemons { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons
            case .failure(let error):
                print("Error fetching pokemons:", error)
            }
        }
    }
}
