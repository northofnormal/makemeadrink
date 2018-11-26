//
//  InventoryViewController.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 8/15/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController {
    
    let cocktailStore = { () -> CocktailStore in
        let newCocktailStore = CocktailStore()
        newCocktailStore.loadPersistentStores(completionHandler: { description, error in
            if (error != nil) {
                print("\(String(describing: error))")
            }
        })
        return newCocktailStore
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationViewController = segue.destination as? AddInventoryViewController else {
            return
        }
        
        destinationViewController.configureWith(cocktailStore)
    }
}
