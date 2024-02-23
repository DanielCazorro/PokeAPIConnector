//
//  PokedexController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 23/2/24.
//

import UIKit

class PokedexController: UICollectionViewController {
    
    // MARK: - Properties
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
    }
    
    // MARK: - Helper Functions
    
    func configureViewComponents() {
        collectionView.backgroundColor = .white
    }
}
