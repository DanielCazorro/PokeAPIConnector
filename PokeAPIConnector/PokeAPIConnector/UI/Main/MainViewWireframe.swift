//
//  MainViewWireframe.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

class MainViewWireframe {
    
    //MARK: - Properties
    
    var viewController: MainViewController {
        // Generating module components
        let viewController = MainViewController()
        let dataManager: MainViewControllerDataManager = createDataManager()
        let viewModel: MainViewModel = createViewModel(with: dataManager)
        viewController.set(viewModel: viewModel)
        return viewController
    }
    
    
    // MARK: - Private methods
    private func createDataManager() -> MainViewControllerDataManager {
        let dataManager = MainViewControllerDataManager()
        return dataManager
    }
    
    private func createViewModel(with dataManager: MainViewControllerDataManager) -> MainViewModel {
        return MainViewModel(dataManager: MainViewControllerDataManager())
    }
}

