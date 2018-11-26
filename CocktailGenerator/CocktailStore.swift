//
//  CocktailStore.swift
//  CocktailGenerator
//
//  Created by Anne Cahalan on 8/1/17.
//  Copyright © 2017 Anne Cahalan. All rights reserved.
//

import CoreData
import Foundation

// Note: be more pedantic about naming, maybe change "ingredient" to "liquor" 

class CocktailStore: NSPersistentContainer {

    init() {
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: "Cocktails", withExtension: "momd") else {
            NSLog("Could not find momd")
            fatalError()
        }
        
        guard let objectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            NSLog("Failed to initialize object model")
            fatalError()
        }
        
        super.init(name: "Cocktails", managedObjectModel: objectModel)
        
        // very important: when you use background context to do a thing, those changes will get propogated to view context
        viewContext.automaticallyMergesChangesFromParent = true
    }
    
}
