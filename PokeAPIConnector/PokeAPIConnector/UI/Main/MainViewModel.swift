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
    private var pokemon: Pokemon?  // Datos de Pokemon obtenidos de la API
    private var pokemonBusiness: PokemonBusiness?  // Datos de Pokemon procesados para la lógica de negocio
    private var swNetwork: Bool = true  // Estado del switch de red
    private var swCombine: Bool = false  // Estado del switch de Combine
    
    var cancellables: Set<AnyCancellable> = []  // Almacenar los suscriptores Combine
    
    let reloadTableView = PassthroughSubject<Void, Never>()  // Sujeto Combine para recargar la tabla
    
    init(dataManager: MainViewDataManager) {
        self.dataManager = dataManager
    }
    
    //MARK: - Switch control
    
    // Cambiar el estado de los switches
    func change(switch selector: SwitchEnum, value: Bool) {
        switch selector {
        case .network:
            swNetwork = value
        case .combine:
            swCombine = value
        }
        
        reloadApi()
    }
    
    // Obtener el valor de un switch
    func getSwitchValue(_ selector: SwitchEnum) -> Bool {
        return switch selector {
        case .network: swNetwork
        case .combine: swCombine
        }
    }
    
    //MARK: - TableView datasource
    
    // Número de filas en la sección de la tabla
    func rowsInSection() -> Int {
        return switch swNetwork {
        case true:
            pokemon?.abilities.count ?? 0
        case false:
            pokemonBusiness?.count ?? 0
        }
    }
    
    // Contenido de la celda en una fila específica
    func cellFor(row: Int) -> String? {
        switch swNetwork {
        case true:
            if 0...((pokemon?.abilities.count ?? 0) - 1) ~= row {
                return pokemon?.abilities[row].ability.name
            }
        case false:
            if 0...((pokemonBusiness?.count ?? 0) - 1) ~= row {
                return pokemonBusiness?[row].name
            }
        }
        return nil
    }
    
    //MARK -  Api calls
    
    // Recargar los datos de la API según el estado de los switches
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
                getPokemonCombineBusiness()
            } else {
                getPokemonClosureBusiness()
            }
        }
    }
    
    // Obtener los datos de Pokemon usando callbacks en la capa de red
    func getPokemonClosureNetwork() {
        dataManager.getPokemonClosureNetwork { pokemon in
            self.pokemon = pokemon
            self.reloadTableView.send()
        } failure: { error in
            print(error)
        }
    }
    
    // Obtener los datos de Pokemon usando callbacks en la capa de negocio
    func getPokemonClosureBusiness() {
        dataManager.getPokemonClosureBusiness { pokemon in
            self.pokemonBusiness = pokemon
            self.reloadTableView.send()
        } failure: { error in
            print(error)
        }
    }
    
    // Obtener los datos de Pokemon usando Combine en la capa de red
    func getPokemonCombineNetwork() {
        dataManager.getPokemonCombineNetwork()
            .sink { /*[weak self]*/ completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] pokemon in
                self?.pokemon = pokemon
                self?.reloadTableView.send()
            }
            .store(in: &cancellables)
    }
    
    // Obtener los datos de Pokemon usando Combine en la capa de negocio
    func getPokemonCombineBusiness() {
        dataManager.getPokemonCombineBusiness()
            .sink { /*[weak self]*/ completion in
                if case let .failure(error) = completion {
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] pokemon in
                self?.pokemonBusiness = pokemon
                self?.reloadTableView.send()
            }
            .store(in: &cancellables)
    }
}
