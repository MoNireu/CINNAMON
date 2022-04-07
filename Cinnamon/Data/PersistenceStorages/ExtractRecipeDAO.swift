//
//  ExtractReicpePersistenceStorage.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/05.
//

import Foundation
import CoreData


class ExtractRecipeDAO {
    
    func fetch() -> [ExtractRecipe]? {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
        let fetchedRecipes = try! context.fetch(fetchRequest) as? [ExtractRecipeEntity]
        
        guard let fetchedRecipes = fetchedRecipes else { return nil }
        var recipeList: [ExtractRecipe] = []
        for fetchedRecipe in fetchedRecipes {
            var recipe = getRecipeFrom(fetchedRecipe)

            guard let fetchedSteps = fetchedRecipe.extractRecipeStep?.array as? [ExtractRecipeStepEntity] else {
                recipeList.append(recipe)
                continue
            }
            for fetchedStep in fetchedSteps {
                let step = getRecipeStepFrom(fetchedStep)
                recipe.steps.append(step)
            }
            recipeList.append(recipe)
        }
        return recipeList
    }
    
    private func getRecipeFrom(_ fetchedRecipe: ExtractRecipeEntity) -> ExtractRecipe {
        return ExtractRecipe(id: fetchedRecipe.id!,
                                   title: fetchedRecipe.title!,
                                   description: fetchedRecipe.desc!,
                                   extractType: ExtractType(rawValue: fetchedRecipe.extractType!)!,
                                   beanAmount: fetchedRecipe.beanAmount,
                                   steps: [],
                                   date: fetchedRecipe.date!)
    }
    
    private func getRecipeStepFrom(_ fetchedStep: ExtractRecipeStepEntity) -> RecipeStep {
        return RecipeStep(id: fetchedStep.id!,
                          title: fetchedStep.title!,
                          description: fetchedStep.desc!,
                          waterAmount: fetchedStep.waterAmount,
                          extractTime: Int(fetchedStep.extractTime))
    }
    
    func fetch2() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeStepEntity")
        let fetchedRecipes = try! context.fetch(fetchRequest) as? [ExtractRecipeStepEntity]
        
        guard let fetchedRecipes = fetchedRecipes else { return }
        for fetchedRecipe in fetchedRecipes {
            var recipe = getRecipeStepFrom(fetchedRecipe)
            print(recipe)
        }
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
        recipeObject.date = recipe.date
        
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
    
    func delete(recipe: ExtractRecipe) -> Bool {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %@", "\(recipe.id)")
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest)
            guard let fetchObject = fetchedObjects.first else { return false }
            context.delete(fetchObject)
            return true
        } catch {
            print(error)
            return false
        }
    }
}
