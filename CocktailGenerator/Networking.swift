//
//  Networking.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 4/8/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import Alamofire
import Foundation

class JSONParser {
    
    let indexURLString = "http://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail"
    let drinkURLBaseString = "http://www.thecocktaildb.com/api/json/v1/1/lookup.php?i="
    
    func fetchIndex(handler: @escaping ([DrinkIndex]?) -> ()) {
        Alamofire.request(indexURLString, method: .get).responseJSON { response in
            var drinkIndex: [DrinkIndex] = []
            if let cocktailJSON = response.result.value as? [String: AnyObject] {
                if let cocktails: [[String: Any]] = cocktailJSON["drinks"] as? [[String : Any]] {
                    drinkIndex = cocktails.flatMap {cocktail in
                        if let cocktailName: String = cocktail["strDrink"] as? String,
                            let cocktailID: String = cocktail["idDrink"] as? String {
                            let cocktailIndex = DrinkIndex(name: cocktailName, id: cocktailID)
                            return cocktailIndex
                        }
                        return nil
                    }
                }
            } else {
                print("there's no JSON 😶")
            }
            
            handler(drinkIndex)
        }
    }
    
    func fetchDrink(id: String, handler: @escaping (Drink?) -> ()) {
        Alamofire.request(drinkURLBaseString + id, method: .get).responseJSON { response in
            if let responseJSON = response.result.value as? [String: AnyObject] {
                if let drinkArray: [[String: Any]] = responseJSON["drinks"] as? [[String: Any]] {
                    let drink: Drink = drinkArray.flatMap { thing in
                        if let drinkName: String =  thing["strName"] as? String,
                            let drinkID: String = thing["idDrink"] as? String,
                            let drinkGlasss: String = thing["strGlass"] as? String,
                            let drinkInstructions: String = thing["strInstructions"] as? String,
                            let drinkIng1: String = thing["strIngredient1"] as? String,
                            let drinkIng2: String = thing["strIngredient2"] as? String,
                            let drinkIng3: String = thing["strIngredient3"] as? String,
                            let drinkIng4: String = thing["strIngredient4"] as? String,
                            let drinkIng5: String = thing["strIngredient5"] as? String,
                            let drinkMeasure1: String = thing["strMeasure1"] as? String,
                            let drinkMeasure2: String = thing["strMeasure2"] as? String,
                            let drinkMeasure3: String = thing["strMeasure3"] as? String,
                            let drinkMeasure4: String = thing["strMeasure4"] as? String,
                            let drinkMeasure5: String = thing["strMeasure5"] as? String {
                                return Drink(name: drinkName, id: drinkID, glass: drinkGlasss, instructions: drinkInstructions, ingredients1: drinkIng1, ingredients2: drinkIng2, ingredients3: drinkIng3, ingredients4: drinkIng4, ingredients5: drinkIng5, measure1: drinkMeasure1, measure2: drinkMeasure2, measure3: drinkMeasure3, measure4: drinkMeasure4, measure5: drinkMeasure5)
                        }
                    }
                    return drink
                }
            } else {
                print("there's no JSON 😶")
            }
            
        }
    }
}

