//
//  MainViewController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 2/2/24.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var sbPokemonSearch: UISearchBar!
    @IBOutlet weak var tvPokemonList: UITableView!
    
    //MARK: - Properties
    var pokemonManager = PokemonManager()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonManager.delegate = self
        
        tvPokemonList.delegate = self
        tvPokemonList.dataSource = self
        
        // Registrar la celda custom
        tvPokemonList.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        pokemonManager.seePokemon()
    }

}

//MARK: - Extensions

extension MainViewController: PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        
    }
    
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPokemonList.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = "Pikachu"
        return cell
    }
}
