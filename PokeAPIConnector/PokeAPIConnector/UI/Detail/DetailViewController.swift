//
//  DetailViewController.swift
//  PokeAPIConnector
//
//  Created by Daniel Cazorro Frias  on 6/2/24.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: Properties
    private var viewModel: DetailViewModel?
    var showPokemon: Pokemon1?

    //MARK: IBOutlet
    @IBOutlet weak var ivPokemonImage: UIImageView!
    @IBOutlet weak var tvPokemonDescrption: UITextView!
    @IBOutlet weak var lbPokemonType: UILabel!
    @IBOutlet weak var lbPokemonAttack: UILabel!
    @IBOutlet weak var lbPokemonDeffense: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // Imagen para mostrar
        ivPokemonImage.loadFrom(URLAddress: showPokemon?.imageUrl ?? "")
        
        
        lbPokemonType.text = "Tipo: \(showPokemon?.type ?? "")"
        lbPokemonAttack.text = "Ataque: \(showPokemon!.attack)"
        lbPokemonDeffense.text = "Defensa: \(showPokemon!.defense)"
        tvPokemonDescrption.text = showPokemon?.description ?? ""
         */
    }


    //MARK: - Functions
    func set(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }

}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
