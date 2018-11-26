//
//  ViewController.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 3/25/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let bartender = JSONParser()
    var cocktailIndex: [DrinkIndex] = []
    
    var selectedDrink: Drink? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bartender.fetchIndex(handler: { drinkIndex in
            guard let index = drinkIndex else { return }
            self.cocktailIndex = index
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailIndex.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IndexTableViewCell.reuseIdentifer) as! IndexTableViewCell
        let drink = cocktailIndex[indexPath.row]
        cell.setupCellFor(drink: drink)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cocktail = cocktailIndex[indexPath.row]
        bartender.fetchDrink(id: cocktail.id, handler: { drink in
            self.selectedDrink = drink
            self.performSegue(withIdentifier: "drinkDetailsSegue", sender: self)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueDestination = segue.destination as? DrinkViewController else { return }
        
        segueDestination.drink = selectedDrink
    }
    
}

public struct DrinkIndex {
    var name: String
    var id: String
    
    public init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}
