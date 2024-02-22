//
//  MainViewModel.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation
import Combine

enum SwitchEnum {
    case network
    case combine
}

class MainViewModel {
    
    private var dataManager: MainViewDataManager
    private var pokemon: Pokemon1?
    private var pokemonBussiness: PokemonBussiness?
    private var swNetwork: Bool = false
    private var swCombine: Bool = false
    let reloadTableView = PassthroughSubject<Void, Never>()
    private var pokemons: [PokemonName]?
    private var cancellables: Set<AnyCancellable> = []
    
    init(dataManager: MainViewDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchData() {
        switch swNetwork {
        case true:
            dataManager.getPokemonClosureNetwork { [weak self] pokemon in
                self?.pokemon = pokemon
                self?.reloadTableView.send()
            } failure: { error in
                print(error)
            }
        case false:
            dataManager.getPokemonClosureBussines(success: { [weak self] pokemonList in
                self?.pokemons = pokemonList
                self?.reloadTableView.send()
            }, failure: { error in
                print("Error fetching data:", error)
            })
        }
    }
    
    func numberOfRoew() -> Int {
        pokemons?.count ?? 0
    }
    
    func pokemonName(at index: Int) -> String? {
        guard let pokemons = pokemons, index < pokemons.count else { return nil }
        return pokemons[index].name
    }
    
    //MARK: - Switch control
    func change(switch selector: SwitchEnum, value: Bool) {
        switch selector {
        case .network:
            swNetwork = value
        case .combine:
            swCombine = value
        }
        
        reloadApi()
    }
    
    func getSwitchValue(_ selector: SwitchEnum) -> Bool {
        return switch selector {
        case .network: swNetwork
        case .combine: swCombine
        }
    }
    
    
    //MARK: - TableView datasource
    func rowsInSection() -> Int {
        return switch swNetwork {
        case true:
            pokemon?.abilities.count ?? 0
        case false:
            pokemonBussiness?.count ?? 0
        }
        
    }
    
    func cellFor(row: Int) -> String? {
        switch swNetwork {
        case true:
            if 0...((pokemon?.abilities.count ?? 0) - 1) ~= row {
                return pokemon?.abilities[row].ability.name
            }
            
        case false:
            if 0...((pokemonBussiness?.count ?? 0) - 1) ~= row {
                return pokemonBussiness?[row].name
            }
        }
        
        return nil
    }
    
    //MARK -  Api calls
    func reloadApi() {
        switch swNetwork {
        case true:
            getPokemonClosureNetwork()
        case false:
            getPokemonClosureBussines()
        }
    }
    
    func getPokemonClosureNetwork() {
        dataManager.getPokemonClosureNetwork { pokemon in
            self.pokemon = pokemon
            self.reloadTableView.send()
        } failure: { error in
            print(error)
        }
    }
    
    func getPokemonClosureBussines() {
        dataManager.getPokemonClosureBussines { pokemon in
            self.pokemonBussiness = pokemon
            self.reloadTableView.send()
        } failure: { error in
            print(error)
        }
    }
}
    /*
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
*/
