//
//  DrinkViewController.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 5/4/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import UIKit

class DrinkViewController: UIViewController {


}


struct Drink {
    var name: String
    var id: String
    var glass: String
    var instructions: String
    var ingredient1: String
    var ingredient2: String
    var ingredient3: String
    var ingredient4: String
    var ingredient5: String
    var measure1: String
    var measure2: String
    var measure3: String
    var measure4: String
    var measure5: String
    
    public init(name: String, id: String, glass: String, instructions: String, ingredients1: String, ingredients2: String, ingredients3: String, ingredients4: String, ingredients5: String, measure1: String, measure2: String, measure3: String, measure4: String, measure5: String) {
        
        self.name = name
        self.id = id
        self.glass = glass
        self.instructions = instructions
        self.ingredient1 = ingredients1
        self.ingredient2 = ingredients2
        self.ingredient3 = ingredients3
        self.ingredient4 = ingredients4
        self.ingredient5 = ingredients5
        self.measure1 = measure1
        self.measure2 = measure2
        self.measure3 = measure3
        self.measure4 = measure4
        self.measure5 = measure5
    }
}
