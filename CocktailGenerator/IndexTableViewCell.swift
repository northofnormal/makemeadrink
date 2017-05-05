//
//  IndexTableViewCell.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 4/7/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import UIKit

class IndexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var glassTypeLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    open static let reuseIdentifer = "IndexCell"

    func setupCellFor(drink: DrinkIndex) {
        drinkNameLabel.text = drink.name
    }
}
