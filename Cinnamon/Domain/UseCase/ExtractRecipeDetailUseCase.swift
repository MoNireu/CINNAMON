//
//  ExtractRecipeDetailUseCase.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/24.
//

import Foundation
import Combine

class ExtractRecipeDetailUseCase {
    private var cancelBag = Set<AnyCancellable>()
    private var repository: ExtractRecipeRepository = ExtractRecipeRepositoryImpl.shared
    var getRecipe = PassthroughSubject<ExtractRecipe, Never>()
    private let recipeId: UUID
    
    init(recipeId: UUID) {
        print("Log -", #fileID, #function, #line)
        self.recipeId = recipeId
        
        passRecipeFromRepository()
    }
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func addNewStep(to recipe: ExtractRecipe) {
        var recipe = recipe
        recipe.steps.append(RecipeStep())
        getRecipe.send(recipe)
    }
    
    func updateRecipe(_ recipe: ExtractRecipe) {
        repository.update(newRecipe: recipe)
    }
    
    private func passRecipeFromRepository() {
        repository.getListSubject
            .sink { [weak self] retrivedRecipes in
                if let recipe = self?.findRecipeById(recipes: retrivedRecipes) {
                    self?.getRecipe.send(recipe)
                }
                else {
                    print("Log -", #fileID, #function, #line, "Error: Could not found recipe by Id")
                }
            }
            .store(in: &cancelBag)
    }
    
    private func findRecipeById(recipes: [ExtractRecipe]) -> ExtractRecipe? {
        return recipes.first(where: { $0.id == recipeId })
    }
}
