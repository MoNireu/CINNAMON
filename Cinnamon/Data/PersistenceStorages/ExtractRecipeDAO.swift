//
//  ExtractReicpePersistenceStorage.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/05.
//

import Foundation
import CoreData


class ExtractRecipePersistenceStorage {
    
    func fetch() -> [NSManagedObject] {
        let context = PersistenceController.shared.container.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
        
        let result = try! context.fetch(fetchRequest)
        
        return result
    }
    
    func save(recipe: ExtractRecipe) -> Bool {
        let context = PersistenceController.shared.container.viewContext
        
        let recipeObject = NSEntityDescription.insertNewObject(forEntityName: "ExtractRecipeEntity", into: context) as! ExtractRecipeEntity
                
        recipeObject.id = recipe.id
        recipeObject.title = recipe.title
        recipeObject.desc = recipe.description
        recipeObject.extractType = recipe.extractType.rawValue
        recipeObject.beanAmount = recipe.beanAmount
        recipeObject.totalExtractTime = Int16(recipe.totalExtractTime)
        recipeObject.totalWaterAmount = recipe.totalWaterAmount
        
        for step in recipe.steps {
            let stepObject = NSEntityDescription.insertNewObject(forEntityName: "ExtractRecipeStepEntity", into: context) as! ExtractRecipeStepEntity
            
            stepObject.id = step.id
            stepObject.title = step.title
            stepObject.desc = step.description
            stepObject.waterAmount = step.waterAmount!
            stepObject.extractTime = Int16(step.extractTime)
    
            recipeObject.addToExtractRecipeStep(stepObject)
        }
        
        do {
            try context.save()
            print("Log -", #fileID, #function, #line, "Save Recipe Success")
            return true
        } catch {
            context.rollback()
            print("Log -", #fileID, #function, #line, "Error: Save Recipe Failed")
            return false
        }
        
    }
}
