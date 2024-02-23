//
//  SceneDelegate.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 2/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Creamos una instancia del ViewController principal usando MainViewWireframe
        let viewController = MainViewWireframe().viewController
        
        // Configuramos la ventana
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        
        // Establecemos el ViewController principal como el rootViewController de la ventana
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Llamado cuando la escena está siendo liberada por el sistema.
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Llamado cuando la escena pasa de un estado inactivo a un estado activo.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Llamado cuando la escena pasará de un estado activo a un estado inactivo.
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Llamado cuando la escena transiciona del fondo al primer plano.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Llamado cuando la escena transiciona del primer plano al fondo.
    }
}
