//
//  MainViewWireframe.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit

class MainViewWireframe {
    
    //MARK: - Properties
    var viewController: MainViewController {
        // Generating module components
        let viewController: MainViewController = MainViewController(nibName: nil, bundle: nil)
        let dataManager: MainViewDataManager = createDataManager()
        let viewModel: MainViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    // MARK: - Private methods
    private func createDataManager() -> MainViewDataManager {
        let dataManager = MainViewDataManager()
        return dataManager
    }
    
    private func createViewModel(with dataManager: MainViewDataManager) -> MainViewModel {
        return MainViewModel(dataManager: MainViewDataManager())
    }
    
    // MARK: - Public methods
    ///Función genérica para navegar a otro ViewController
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}

