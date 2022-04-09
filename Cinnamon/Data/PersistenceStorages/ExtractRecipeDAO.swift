//
//  ExtractReicpePersistenceStorage.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/05.
//

import Foundation
import CoreData
import Combine


enum DAOError: String, Error {
    case fetchFailed = "Error: Fetch Failed"
    case saveFailed = "Error: Save Failed"
    case updateFailed = "Error: Update Failed"
    case deleteFailed = "Error: Delete Failed"
}


struct ExtractRecipeDAO {
    
    func fetch() -> Future<[ExtractRecipe], Error> {
        return Future() { promise in
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
            let fetchedRecipes = try? context.fetch(fetchRequest) as? [ExtractRecipeEntity]
            
            guard let fetchedRecipes = fetchedRecipes else { return promise(.failure(DAOError.fetchFailed)) }
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
            promise(.success(recipeList))
        }
    }
    
    // TEST: TestCode
    func fetchAllSteps() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeStepEntity")
        let fetchedSteps = try! context.fetch(fetchRequest) as? [ExtractRecipeStepEntity]
        
        guard let fetchedRecipes = fetchedSteps else { return }
        for fetchedRecipe in fetchedRecipes {
            let recipe = getRecipeStepFrom(fetchedRecipe)
            print(recipe)
        }
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
    
    
    func save(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error> {
        return Future() { promise in
            let context = PersistenceController.shared.container.viewContext
            
            let recipeObject = NSEntityDescription.insertNewObject(forEntityName: "ExtractRecipeEntity", into: context) as! ExtractRecipeEntity
            
            setRecipeObject(recipeObject, from: recipe)
            
            for step in recipe.steps {
                let stepObject = NSEntityDescription.insertNewObject(forEntityName: "ExtractRecipeStepEntity", into: context) as! ExtractRecipeStepEntity
                setStepObject(stepObject, from: step)
                recipeObject.addToExtractRecipeStep(stepObject)
            }
            
            do {
                try context.save()
                print("Log -", #fileID, #function, #line, "Save Recipe Success")
                promise(.success(recipe))
            } catch {
                context.rollback()
                print("Log -", #fileID, #function, #line, "Error: Save Recipe Failed")
                promise(.failure(DAOError.saveFailed))
            }
        }
    }

    
    func update(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error> {
        return Future() { promise in
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(recipe.id)")
            
            do {
                guard let recipeObject = try context.fetch(fetchRequest).first as? ExtractRecipeEntity else {
                    promise(.failure(DAOError.updateFailed))
                    return
                }
                setRecipeObject(recipeObject, from: recipe)
                
                guard let stepObjects = recipeObject.extractRecipeStep?.array as? [NSManagedObject] else {
                    promise(.failure(DAOError.updateFailed))
                    return
                }
                
                for stepObject in  stepObjects {
                    context.delete(stepObject)
                }
                
                for step in recipe.steps {
                    let stepObject = NSEntityDescription.insertNewObject(forEntityName: "ExtractRecipeStepEntity", into: context) as! ExtractRecipeStepEntity
                    setStepObject(stepObject, from: step)
                    recipeObject.addToExtractRecipeStep(stepObject)
                }
                
                do {
                    try context.save()
                    promise(.success(recipe))
                    
                } catch {
                    print(error)
                    promise(.failure(DAOError.updateFailed))
                }
            } catch {
                print(error)
                promise(.failure(DAOError.updateFailed))
            }
        }
    }
    
    private func setRecipeObject(_ recipeObject: ExtractRecipeEntity, from recipe: ExtractRecipe) {
        recipeObject.id = recipe.id
        recipeObject.title = recipe.title
        recipeObject.desc = recipe.description
        recipeObject.extractType = recipe.extractType.rawValue
        recipeObject.beanAmount = recipe.beanAmount
        recipeObject.totalExtractTime = Int16(recipe.totalExtractTime)
        recipeObject.totalWaterAmount = recipe.totalWaterAmount
        recipeObject.date = recipe.date
    }
    
    private func setStepObject(_ stepObject: ExtractRecipeStepEntity, from step: RecipeStep) {
        stepObject.id = step.id
        stepObject.title = step.title
        stepObject.desc = step.description
        stepObject.waterAmount = step.waterAmount!
        stepObject.extractTime = Int16(step.extractTime)
    }
    
    
    
    func delete(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error> {
        return Future { promise in
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ExtractRecipeEntity")
            fetchRequest.predicate = NSPredicate(format: "id = %@", "\(recipe.id)")
            
            do {
                let fetchedObjects = try context.fetch(fetchRequest)
                guard let fetchObject = fetchedObjects.first else {
                    promise(.failure(DAOError.deleteFailed))
                    return
                }
                context.delete(fetchObject)
                promise(.success(recipe))
            } catch {
                promise(.failure(DAOError.deleteFailed))
            }
        }
    }
}
