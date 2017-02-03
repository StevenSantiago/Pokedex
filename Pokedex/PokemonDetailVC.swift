//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Steven Santiago on 2/1/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var evolutionLbl: UILabel!
    @IBOutlet weak var currentEvol: UIImageView!
    @IBOutlet weak var nextEvol: UIImageView!
    @IBOutlet weak var pokedexId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
        mainImg.image = UIImage(named: String(pokemon.pokedexId))
        currentEvol.image = UIImage(named: String(pokemon.pokedexId))
        if pokemon.nextEvolution.contains("") {
        nextEvol.image = nil
        } else {
            nextEvol.image = UIImage(named: String(pokemon.pokedexId + 1))
        }
        pokedexId.text = String(pokemon.pokedexId)
        
        pokemon.downloadPokemonDetail {
            
            self.updateUI()
            
        }
        
        
    }
    
    func updateUI() {
        nameLbl.text = pokemon.name
        type.text = pokemon.type
        descriptionLbl.text = pokemon.description
        defense.text = pokemon.defense
        attack.text = pokemon.attack
        weight.text = pokemon.weight
        height.text = pokemon.height
        pokedexId.text = String(pokemon.pokedexId)
        mainImg.image = UIImage(named: String(pokemon.pokedexId))
        currentEvol.image = UIImage(named: String(pokemon.pokedexId))
        if pokemon.nextEvolution.contains("") {
            nextEvol.image = nil
        } else {
            nextEvol.image = UIImage(named: String(pokemon.pokedexId + 1))
        }

    }
   

    @IBAction func backPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
  

}
