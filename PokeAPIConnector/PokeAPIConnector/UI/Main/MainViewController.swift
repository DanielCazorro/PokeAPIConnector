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
    
    //MARK: - IBOutlets
    @IBOutlet weak var sbPokemonSearch: UISearchBar!
    @IBOutlet weak var tvPokemonList: UITableView!
    @IBOutlet weak var swNetwork: UISwitch!
    @IBOutlet weak var swCombine: UISwitch!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        responseViewModel()
        swNetwork.isOn = viewModel?.getSwitchValue(.network) ?? false
        swCombine.isOn = viewModel?.getSwitchValue(.combine) ?? false
        viewModel?.reloadApi()
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
    
    // MARK: - IBActions
    @IBAction func swNetworkAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        viewModel?.change(switch: .network, value: sw.isOn)
    }
    
    @IBAction func swCombineAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        viewModel?.change(switch: .combine, value: sw.isOn)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell with data from the ViewModel
         if let viewModel = viewModel {
             let pokemonData = viewModel.pokemonDataFor(row: indexPath.row)
             cell.lbPokemonName.text = pokemonData.name
             // You can continue configuring other UI elements in the cell here
         }
         
         return cell
     }
 }
