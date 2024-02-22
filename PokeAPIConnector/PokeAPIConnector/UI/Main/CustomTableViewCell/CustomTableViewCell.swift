//
//  CustomTableViewCell.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "CustomTableViewCell"
    
    // MARK: - IBOutlet
    @IBOutlet weak var imPokemon: UIImageView!
    @IBOutlet weak var lbPokemonName: UILabel!
    @IBOutlet weak var lbAttack: UILabel!
    @IBOutlet weak var lbDefense: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round the corners of the image view
        imPokemon.layer.cornerRadius = 15
        imPokemon.clipsToBounds = true // Ensure that the image view's content doesn't extend beyond its bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset the image to avoid displaying old data
        //imPokemon.image = nil
        //lbPokemonName.text = ""
        //lbAttack.text = ""
        //lbDefense.text = ""
        
    }
}
