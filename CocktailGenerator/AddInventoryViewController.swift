//
//  AddInventoryViewController.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 8/15/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import UIKit

class AddInventoryViewController: UIViewController {

    @IBOutlet weak var alcoholTypeField: UITextField!
    @IBOutlet weak var brandNameField: UITextField!
    @IBOutlet weak var bottleSizeField: UITextField!
    
    var cocktailStore: CocktailStore?
    
    @IBAction func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped() {
        cocktailStore?.performBackgroundTask { context in
            let savedIngredient = Ingredient(context: context)
            savedIngredient.name = self.brandNameField.text
            savedIngredient.type = self.alcoholTypeField.text
            savedIngredient.bottleSize = self.bottleSizeField.text
            
            do {
                try context.save()
            } catch {
                print("This Failed")
                // do a thing (log a failure, throw an alert, etc) 
                // can fail if, for example, the objects don't conform to the core data constraints 
                // for example, if you tried to assign nil to a nonoptional property
            }
        }
        
        dismiss(animated: true)
    }
    
    func configureWith(_ cocktailStore: CocktailStore) {
        self.cocktailStore = cocktailStore
    }

}
