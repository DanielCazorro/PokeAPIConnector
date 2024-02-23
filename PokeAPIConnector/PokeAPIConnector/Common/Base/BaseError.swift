//
//  BaseError.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

// Enumeración que representa los posibles errores base
enum BaseError: Error {
    case generic  // Error genérico
    case noInternetConnection  // Falta de conexión a Internet
    
    // Método para obtener una descripción del error
    func description() -> String {
        
        var description: String = ""
        
        // Switch para determinar la descripción del error
        switch self {
        case .generic: description = "Error genérico"
        case .noInternetConnection: description = "No hay conexión a Internet"
        }
        
        return description
    }
}
