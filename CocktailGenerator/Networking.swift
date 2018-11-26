//
//  Networking.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 4/8/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import Alamofire
import Foundation

typealias JSONValue = [String: AnyObject]

// maybe this needs a different name
class JSONParser {
    
    let indexURLString = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    let drinkURLBaseString = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    
    func fetchIndex(handler: @escaping ([DrinkIndex]?) -> ()) {
        Alamofire.request(indexURLString, method: .get).responseJSON { response in
            // parser returns this
            var drinkIndex: [DrinkIndex] = []
            
            guard let cocktailJSON = response.result.value as? JSONValue else {
                print("there's no JSON 😶")
                return
            }
            // sent the response to the parser
            
            // all this goes to the parser 
            guard let cocktails: [JSONValue] = cocktailJSON["drinks"] as? [JSONValue] else { return }
            
            // time to pull this into it's own JSON Parser class
            // and have its own tests
            drinkIndex = cocktails.flatMap { cocktail in
                if let cocktailName: String = cocktail["strDrink"] as? String,
                    let cocktailID: String = cocktail["idDrink"] as? String {
                    let cocktailIndex = DrinkIndex(name: cocktailName, id: cocktailID)
                    return cocktailIndex
                }
                return nil
            }
            
            handler(drinkIndex)
        }
    }
    
    func fetchDrink(id: String, handler: @escaping (Drink?) -> ()) {
        Alamofire.request(drinkURLBaseString + id, method: .get).responseJSON { response in
            var selectedDrink: Drink
            
            guard let responseJSON = response.result.value as? JSONValue else {
                print("there's no JSON 😶")
                return
            }
            
            guard let drinkArray: [JSONValue] = responseJSON["drinks"] as? [JSONValue] else { return }
            
            guard let drink = drinkArray.first else { return }
            
            if let drinkName: String =  drink["strDrink"] as? String,
                let drinkID: String = drink["idDrink"] as? String,
                let drinkGlasss: String = drink["strGlass"] as? String,
                let drinkInstructions: String = drink["strInstructions"] as? String,
                let drinkIng1: String = drink["strIngredient1"] as? String,
                let drinkIng2: String = drink["strIngredient2"] as? String,
                let drinkIng3: String = drink["strIngredient3"] as? String,
                let drinkIng4: String = drink["strIngredient4"] as? String,
                let drinkIng5: String = drink["strIngredient5"] as? String,
                let drinkMeasure1: String = drink["strMeasure1"] as? String,
                let drinkMeasure2: String = drink["strMeasure2"] as? String,
                let drinkMeasure3: String = drink["strMeasure3"] as? String,
                let drinkMeasure4: String = drink["strMeasure4"] as? String,
                let drinkMeasure5: String = drink["strMeasure5"] as? String {
                selectedDrink = Drink(name: drinkName, id: drinkID, glass: drinkGlasss, instructions: drinkInstructions, ingredients1: drinkIng1, ingredients2: drinkIng2, ingredients3: drinkIng3, ingredients4: drinkIng4, ingredients5: drinkIng5, measure1: drinkMeasure1, measure2: drinkMeasure2, measure3: drinkMeasure3, measure4: drinkMeasure4, measure5: drinkMeasure5)
                
                handler(selectedDrink)
            }
        }
    }
}

