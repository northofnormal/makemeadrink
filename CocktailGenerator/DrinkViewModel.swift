//
//  DrinkViewModel.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 6/22/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import Foundation


class DrinkViewModel {
    
    public func ingredientsString(drink: Drink) -> String {
        let ingredientsString = "\(drink.measure1) \(drink.ingredient1)\n\(drink.measure2) \(drink.ingredient2)\n\(drink.measure3) \(drink.ingredient3)\n\(drink.measure4) \(drink.ingredient4)\n\(drink.measure5) \(drink.ingredient5)"
        return ingredientsString
    }
    
}
