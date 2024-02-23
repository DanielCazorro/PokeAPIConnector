//
//  CustomTableViewCell.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // Identificador estático para reutilizar la celda
    static let identifier = "CustomTableViewCell"
    
    // MARK: - IBOutlet
    
    // Outlets para los elementos de la celda
    @IBOutlet weak var imPokemon: UIImageView!
    @IBOutlet weak var lbPokemonName: UILabel!
    @IBOutlet weak var lbAttack: UILabel!
    @IBOutlet weak var lbDefense: UILabel!
    
    // MARK: - Lifecycle
    
    // Configurar la celda cuando se despierta desde la interfaz Builder
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Redondear las esquinas de la imagen
        imPokemon.layer.cornerRadius = 15
        imPokemon.clipsToBounds = true // Asegurar que el contenido de la imagen no se extienda más allá de sus límites
    }
    
    // Restablecer el estado de la celda antes de reutilizarla
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Restablecer la imagen para evitar mostrar datos antiguos
        imPokemon.image = nil
        lbPokemonName.text = ""
        lbAttack.text = ""
        lbDefense.text = ""
    }
}
