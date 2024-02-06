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
    private var wireframe = MainViewWireframe()
    var pokemonManager = PokemonManager()
    var pokemons: [Pokemon] = []
    var pokemonChosen: Pokemon?
    
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
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPokemonList.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.lbPokemonName.text = pokemons[indexPath.row].name.capitalized
        cell.lbAttack.text = "Ataque: \(pokemons[indexPath.row].attack)"
        cell.lbDefense.text = "Defensa: \(pokemons[indexPath.row].defense)"
        
        // Celda imagen desde URL
        if let urlString = pokemons[indexPath.row].imageUrl as? String {
            if let imageURL = URL(string: urlString) {
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageURL) else
                    {return}
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.imPokemon.image = image
                    }
                }
            }
            
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            120
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonChosen = pokemons[indexPath.row]
        
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        detailVC.showPokemon = pokemonChosen
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
extension MainViewController: PokemonManagerDelegate {
    func showListPokemon(list: [Pokemon]) {
        pokemons = list
        
        DispatchQueue.main.async {
            self.tvPokemonList.reloadData()
        }
    }
    
    
}

