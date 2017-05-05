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
    
    // remember this: http://stackoverflow.com/questions/27390656/how-to-return-value-from-alamofire
    // specifically, the "orders" parameter
    
    // name this better
    func fetchIndex(handler: @escaping ([AnyObject]?) -> ()) {
        makeCall(indexURLString, completionHandler: handler)
    }
    
    func fetchDrink(id: String, handler: @escaping ([AnyObject]?) -> ()) {
        makeCall(drinkURLBaseString + id, completionHandler: handler)
    }
    
    func makeCall(_ url: String, completionHandler: @escaping ([AnyObject]) -> ()) {
        
        Alamofire.request(url, method: .get).responseJSON { response in
            
            switch url {
            case self.indexURLString:
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
                
                completionHandler(drinkIndex as [AnyObject])
                return
                // well this doesn't work bc the URL includes the id part now :facepalm: 
                // but I am hitting the correct url and getting back the expected response. 
            case self.drinkURLBaseString:
                print(response.result.value)
                return
                
            default: break
            }
            
            
        }
    }
    
}
