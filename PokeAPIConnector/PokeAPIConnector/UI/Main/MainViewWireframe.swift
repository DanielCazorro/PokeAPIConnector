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
        
        // Creamos una instancia de MainViewController
        let viewController: MainViewController = MainViewController(nibName: nil, bundle: nil)
        
        // Creamos una instancia de MainAPIClient para manejar las llamadas a la API
        let apiClient: MainAPIClient = MainAPIClient()
        
        // Creamos una instancia de MainViewDataManager que se encargará de manejar los datos
        let dataManager: MainViewDataManager = createDataManager(apiClient: apiClient)
        
        // Creamos una instancia de MainViewModel que utilizará el dataManager
        let viewModel: MainViewModel = createViewModel(with: dataManager)
        
        // Configuramos el viewModel en el viewController
        viewController.set(viewModel: viewModel)
        
        // Retornamos el viewController
        return viewController
    }
    
    // Creamos una instancia de MainAPIClient para manejar las llamadas a la API
    private var apiClient: MainAPIClient {
        return MainAPIClient()
    }
    
    // MARK: - Private methods
    
    // Creamos una instancia de MainViewDataManager que utilizará el apiClient
    private func createDataManager(apiClient: MainAPIClient) -> MainViewDataManager {
        let dataManager = MainViewDataManager(apiClient: apiClient)
        return dataManager
    }
    
    // Creamos una instancia de MainViewModel que utilizará el dataManager
    private func createViewModel(with dataManager: MainViewDataManager) -> MainViewModel {
        return MainViewModel(dataManager: dataManager)
    }
    
    // MARK: - Public methods
    
    /// Función genérica para navegar a otro ViewController
    func push(navigation: UINavigationController?) {
        guard let navigation = navigation else { return }
        navigation.pushViewController(viewController, animated: true)
    }
}
