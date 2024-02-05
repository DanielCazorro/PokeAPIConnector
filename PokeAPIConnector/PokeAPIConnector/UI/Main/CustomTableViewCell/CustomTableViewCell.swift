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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        lbPokemonName.text = nil
        imPokemon.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    /*
    func configureCell(with pokemon: Pokemon) {
        lbPokemonName.text = pokemon.name
        
        // Verificamos si la URL de la imagen está disponible en la propiedad sprites
        if let imageURL = URL(string: pokemon.sprites?.front_default ?? "") {
            // Descargamos la imagen desde la URL de forma asíncrona
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
                if let error = error {
                    print("Error al descargar la imagen: \(error.localizedDescription)")
                    return
                }
                
                // Verificamos si se recibieron datos de la imagen
                if let imageData = data {
                    // Convertimos los datos de la imagen en UIImage
                    if let image = UIImage(data: imageData) {
                        // Actualizamos la imagen en el hilo principal
                        DispatchQueue.main.async {
                            self?.imPokemon.image = image
                        }
                    }
                }
            }.resume() // Iniciamos la tarea de URLSession para descargar la imagen
        }
    }
     */
}
