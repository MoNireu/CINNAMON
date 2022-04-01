//
//  ExtractRecipeRepository.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine


class ExtractRecipeRepository: ObservableObject {
    
    static let shared: ExtractRecipeRepository = ExtractRecipeRepository()
    private var cache: [ExtractRecipe]
    
    var getListSubject = PassthroughSubject<[ExtractRecipe], Never>()
    var createdRecipeSubject = PassthroughSubject<ExtractRecipe, Never>()
    
    private init() {
        print("Log -", #fileID, #function, #line)
        cache = []
    }
    
    func fetch() -> Future<Bool, Never> {
        return Future() { [weak self] promise in
            print("Log -", #fileID, #function, #line)
            self?.cache = ExtractRecipeDummyData.extractRecipeList
            promise(.success(true))
        }
    }
    
    func get() {
        print("Log -", #fileID, #function, #line)
        getListSubject.send(cache)
    }
    
    func add(newRecipe: ExtractRecipe){
        cache.append(newRecipe)
        get()
        createdRecipeSubject.send(newRecipe)
    }
    
    func add(newStep: RecipeStep, to recipe: ExtractRecipe) {
        
    }
    
    @discardableResult
    func update(newRecipe: ExtractRecipe) -> Future<ExtractRecipe, Error> {
        return Future { [weak self] promise in
            if let index = self?.getRecipeIndex(recipe: newRecipe) {
                self?.cache[index] = newRecipe
                print("Log -", #fileID, #function, #line, "Recipe Updated!")
                promise(.success(newRecipe))
                self?.get()
            }
            else {
                print("Log -", #fileID, #function, #line, "Error: Recipe Not Found")
                promise(.failure(NSError()))
            }
        }
    }
    
    private func getRecipeIndex(recipe: ExtractRecipe) -> Int? {
        return cache.firstIndex(where: {$0.id == recipe.id})
    }
}
