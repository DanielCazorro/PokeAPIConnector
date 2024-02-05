//
//  MainViewController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 2/2/24.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var tvPokemonList: UITableView!
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print(PokeAPIConnector.fetchPokemonData())
    }
}
