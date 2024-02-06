//
//  BaseError.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import Foundation

enum ErrorType {
    
    case fullScreen(String)
    case alert(String)
    case form(String)
    case popup(String)
}

enum BaseError: Error {
    case generic
    case noInternetConnection
    case credentials
    
    func description() -> String {
        
        var description: String = ""
        
        switch self {
        case .generic: description = "error_generic"
        case .noInternetConnection: description = "error_no_internet_connection"
        case .credentials: description = "error_credential"
        }
        
        return description
    }
}

