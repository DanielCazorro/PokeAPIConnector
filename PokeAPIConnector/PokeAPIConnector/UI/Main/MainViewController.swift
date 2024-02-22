//
//  MainViewController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 2/2/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    //MARK: Properties
    private var viewModel: MainViewModel?
    var pokemonEntries: [PokemonEntry] = []
    let pokeApi = PokeApi()
    let pokemonSelectedApi = PokemonSelectedApi()
    
    //MARK: - IBOutlets
    @IBOutlet weak var sbPokemonSearch: UISearchBar!
    @IBOutlet weak var tvPokemonList: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvPokemonList.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)


        tvPokemonList.dataSource = self
        fetchPokemonData()
    }
    
    //MARK: - Functions
    func set(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func fetchPokemonData() {
        pokeApi.getData { [weak self] pokemonEntries in
            self?.pokemonEntries = pokemonEntries
            self?.tvPokemonList.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell

        let pokemonEntry = pokemonEntries[indexPath.row]
        cell.lbPokemonName.text = pokemonEntry.name ?? ""
        // Aquí puedes agregar más configuraciones de celda según tus necesidades
        return cell
    }
}
