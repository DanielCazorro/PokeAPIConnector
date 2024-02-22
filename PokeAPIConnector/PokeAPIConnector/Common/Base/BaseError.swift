//
//  BaseError.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

enum BaseError: Error {
    case generic
    case noInternetConnection
    
    func description() -> String {
        
        var description: String = ""
        
        switch self {
        case .generic: description = "Error generico"
        case .noInternetConnection: description = "NO hay conexion"
        }
        
        return description
    }
}
