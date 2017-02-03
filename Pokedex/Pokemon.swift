//
//  Pokemon.swift
//  Pokedex
//
//  Created by Steven Santiago on 1/29/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _weight: String!
    fileprivate var _height: String!
    fileprivate var _nextEvolution: String!
    fileprivate var _description: String!
    fileprivate var _pokemonURL: String!
    
    // Name and pokedex Id are guranteed to not be nil since it comes from the CSV file and from the app itself not online
    var name: String {
        return _name.capitalized
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    // reason for checking for nil instead of setting a default value is to find out if API call works and is pulling correct data and not nil or actual empty string
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var nextEvolution : String {
        if _nextEvolution == nil {
            _nextEvolution = ""
        }
        return _nextEvolution
    }
    
    var description : String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonURL = URL_BASE + URL_POKEMON + "\(self.pokedexId)"
    }
    
    
    func downloadPokemonDetail(completed: @ escaping DownloadComplete) {
        Alamofire.request(self._pokemonURL).responseJSON { (response) in  // JSON response comes back as dictionary
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let attack = dict["attack"] as? Int {
                    self._attack = String(attack)
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = String(defense)
                }
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let types = dict["types"] as? [Dictionary<String,String>] {
                    
                    if let name = types[0]["name"]?.capitalized {
                        self._type = name
                    }
                    if types.count > 1 { // meaning pokemon is dual typed
                        if let name = types[1]["name"]?.capitalized {
                            self._type! += "/\(name)"
                        }
                    }
                }
                if let pokeId = dict["pkdx_id"] as? Int {
                    self._pokedexId = pokeId
                }
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {
                        let descURL = URL_BASE + url
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            if let descDict = response.result.value as? Dictionary<String,AnyObject> {
                                if let description = descDict["description"] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon") // fix typo in API Call
                                    self._description = newDescription
                                }
                            }
                            completed()
                            
                        })
                    }
                } else {
                    self._description = ""
                }
                
            }
            completed()
        }
        
    }
}
