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
        
        // Asignar la función responseViewModel para manejar la actualización de la tabla
        responseViewModel()
        
        // Configurar el estado inicial de los switches y recargar los datos de la API
        swNetwork.isOn = viewModel?.getSwitchValue(.network) ?? false
        swCombine.isOn = viewModel?.getSwitchValue(.combine) ?? false
        viewModel?.reloadApi()
    }
    
    //MARK: - Functions
    
    // Función para configurar el viewModel
    func set(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    // Función para manejar la actualización de la tabla
    func responseViewModel() {
        viewModel?.reloadTableView.sink { [weak self] in
            // Recargar la tabla cuando se recibe una notificación del viewModel
            self?.tvPokemonList.reloadData()
        }.store(in: &cancellables)
    }
    
    // MARK: - IBActions
    
    // Acción del switch de red
    @IBAction func swNetworkAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        viewModel?.change(switch: .network, value: sw.isOn)
    }
    
    // Acción del switch de Combine
    @IBAction func swCombineAction(_ sender: Any) {
        guard let sw = sender as? UISwitch else { return }
        viewModel?.change(switch: .combine, value: sw.isOn)
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Obtener el número de filas de la tabla del viewModel
        return viewModel?.rowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else {
            // Si no se puede obtener una celda reutilizable, retornar una celda vacía
            return UITableViewCell()
        }
        
        // Configurar la celda con datos del viewModel
        if let viewModel = viewModel {
            let pokemonData = viewModel.cellFor(row: indexPath.row)
            cell.lbPokemonName.text = pokemonData
            // Se puede continuar configurando otros elementos de UI en la celda aquí
        }
        
        return cell
    }
}
