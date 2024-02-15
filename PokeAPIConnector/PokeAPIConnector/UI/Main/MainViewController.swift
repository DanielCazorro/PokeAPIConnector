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
    private var cancellables: Set<AnyCancellable> = []
    //private var wireframe = MainViewWireframe()
    //var pokemonManager = PokemonManager()
    //var pokemons: [Pokemon] = []
    //var pokemonChosen: Pokemon?
    
    //MARK: - IBOutlets
    @IBOutlet weak var sbPokemonSearch: UISearchBar!
    @IBOutlet weak var tvPokemonList: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        responseViewModel()
        viewModel?.reloadApi()
        //configureViewModel()
        //configureTableView()
        
        //tvPokemonList.rowHeight = UITableView.automaticDimension
        //tvPokemonList.estimatedRowHeight = 140
        
       // viewModel?.fetchPokemons()
        /*
         pokemonManager.delegate = self
         
         tvPokemonList.delegate = self
         tvPokemonList.dataSource = self
         
         // Registrar la celda custom
         tvPokemonList.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
         
         // Ejecutar el método de búsqueda de pokemon
         pokemonManager.seePokemon()
         */
    }
    
    //MARK: - Functions
    func set(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func responseViewModel() {
        viewModel?.reloadTableView.sink { [weak self] in
            self?.tvPokemonList.reloadData()
        }.store(in: &cancellables)
    }
    /*
    // MARK: - ViewModel Configuration
    private func configureViewModel() {
        let dataManager = MainViewDataManager()
        let viewModel = MainViewModel(dataManager: dataManager)
        
        // Establecer el closure de cambio de pokémon para actualizar la vista cuando cambia la lista de pokémon
        viewModel.pokemonsDidChange = { [weak self] pokemons in
            self?.updatePokemonList(with: pokemons)
        }
        
        self.viewModel = viewModel
    }
    
    // MARK: - TableView Configuration
    private func configureTableView() {
        tvPokemonList.delegate = self
        tvPokemonList.dataSource = self
        tvPokemonList.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
    }
    
    // MARK: - Helper Methods
    private func updatePokemonList(with pokemons: [Pokemon]) {
        DispatchQueue.main.async {
            self.tvPokemonList.reloadData()
        }
    }
    */
}

//MARK: - Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //pokemons.count
        viewModel?.rowsInSection() ?? 0
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = viewModel?.cellFor(row: indexPath.row)
        return cell
        
        //let cell = tvPokemonList.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        /*
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
         }
         
         
         return cell
         */
        /*
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        return cell
         */
    }
    
}

func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    /*
     pokemonChosen = pokemons[indexPath.row]
     
     let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
     detailVC.showPokemon = pokemonChosen
     
     self.navigationController?.pushViewController(detailVC, animated: true)
     
     }
     */
}

/*
 extension MainViewController: PokemonManagerDelegate {
 
 func showListPokemon(list: [Pokemon]) {
 pokemons = list
 
 DispatchQueue.main.async {
 self.tvPokemonList.reloadData()
 }
 }
 
 
 }
 */

