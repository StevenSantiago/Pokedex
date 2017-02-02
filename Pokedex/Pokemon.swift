//
//  Pokemon.swift
//  Pokedex
//
//  Created by Steven Santiago on 1/29/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _attack: String!
    fileprivate var _weight: String!
    fileprivate var _height: String!
    fileprivate var _nextEvolution: String!
    
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
