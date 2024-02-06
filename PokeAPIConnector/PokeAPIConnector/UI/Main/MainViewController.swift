//
//  MainViewController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 2/2/24.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Properties
    private var viewModel: MainViewModel?
    var pokemonManager = PokemonManager()

    //MARK: - IBOutlets
    @IBOutlet weak var sbPokemonSearch: UISearchBar!
    @IBOutlet weak var tvPokemonList: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonManager.delegate = self
        
        tvPokemonList.delegate = self
        tvPokemonList.dataSource = self
        
        // Registrar la celda custom
        tvPokemonList.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        // Ejecutar el método de búsqueda de pokemon
        pokemonManager.seePokemon()
    }
    
    //MARK: - Functions
    func set(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
}

//MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPokemonList.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.lbPokemonName.text = "Pikachu"
        cell.lbAttack.text = "55"
        cell.lbDefense.text = "90"
        cell.imPokemon.image = UIImage(systemName: "person.circle")
        // Celda imagen desde URL

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

extension MainViewController: PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        
    }
    

}
