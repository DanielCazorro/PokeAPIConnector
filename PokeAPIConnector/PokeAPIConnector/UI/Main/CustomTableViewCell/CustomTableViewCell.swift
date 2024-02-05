//
//  CustomTableViewCell.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 5/2/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier = "CustomTableViewCell"
    
    //MARK: - IBoutlet
    @IBOutlet weak var imPokemon: UIImageView!
    @IBOutlet weak var lbPokemonName: UILabel!
    @IBOutlet weak var lbAttack: UILabel!
    @IBOutlet weak var lbDefense: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lbPokemonName.text = "Pikachu"
    }
    /*
    override func prepareForReuse() {
        super.prepareForReuse()
        lbPokemonName.text = nil
        imPokemon.image = nil
    }
*/
 
}
