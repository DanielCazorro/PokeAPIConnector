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
    private var pokemon: Pokemon?
    private var pokemonBussiness: PokemonBusiness?
    private var swNetwork: Bool = true
    private var swCombine: Bool = false
    
    var cancellables: Set<AnyCancellable> = []
    
    let reloadTableView = PassthroughSubject<Void, Never>()
    
    
    init(dataManager: MainViewDataManager) {
        self.dataManager = dataManager
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
            if swCombine {
                getPokemonCombineNetwork()
            } else {
                getPokemonClosureNetwork()
            }
        case false:
            if swCombine {
                getPokemonCombineBussines()
            } else {
                getPokemonClosureBussines()
            }
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
    
    func getPokemonCombineNetwork() {
        dataManager.getPokemonCombineNetwork()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Hay error \(error)")
                }
            } receiveValue: { [weak self] pokemon in
                print("Recargo la tabla de Combine")
                self?.pokemon = pokemon
                self?.reloadTableView.send()
            }
            .store(in: &cancellables)
    }
    
    func getPokemonCombineBussines() {
        dataManager.getPokemonCombineBussines()
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    print("Hay error \(error)")
                }
            } receiveValue: { [weak self] pokemon in
                print("Recargo la tabla de Combine")
                self?.pokemonBussiness = pokemon
                self?.reloadTableView.send()
            }
            .store(in: &cancellables)
    }
    
}
