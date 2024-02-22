//
//  DetailViewWireframe.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 6/2/24.
//

import UIKit

class DetailViewWireframe {
    
    //MARK: - Properties
    var viewController: DetailViewController {
        // Generating module components
        let viewController = DetailViewController()
        let dataManager: DetailViewDataManager = createDataManager()
        let viewModel: DetailViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private methods
    private func createDataManager() -> DetailViewDataManager {
        let dataManager = DetailViewDataManager()
        return dataManager
    }
    
    private func createViewModel(with dataManager: DetailViewDataManager) -> DetailViewModel {
        return DetailViewModel(dataManager: DetailViewDataManager())
    }
    
    // MARK: - Public methods
    ///Función genérica para navegar a otro ViewController
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }

}
