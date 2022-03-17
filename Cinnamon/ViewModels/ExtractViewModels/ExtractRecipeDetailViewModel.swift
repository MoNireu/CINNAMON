//
//  ExtractRecipeDetailViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/16.
//

import Foundation
import Combine
import SwiftUI

class ExtractRecipeDetailViewModel: ObservableObject {
    let extractRecipeListData: ExtractRecipeStore
    @Published var recipe: ExtractRecipe
    @Published var title: String
    @Published var description: String?
    @Published var beanAmount: Float?
    @Published var editedRecipeSteps: [RecipeStep] = [
        RecipeStep(title: "뜸 들이기", description: nil, waterAmount: 40, extractTime: 60),
        RecipeStep(title: "1차 푸어링", description: nil, waterAmount: 80, extractTime: 60),
        RecipeStep(title: "2차 푸어링", description: nil, waterAmount: 40, extractTime: 40)
    ]
    //    var recipeSteps: [RecipeStep]
    
    init(recipe: ExtractRecipe, extractRecipeListData: ExtractRecipeStore) {
        self.extractRecipeListData = extractRecipeListData
        self.recipe = recipe
        self.title = recipe.title
        self.description = recipe.description
        self.beanAmount = recipe.beanAmount
        self.editedRecipeSteps = recipe.recipeSteps
    }
    
    func completeEditing() {
        recipe.title = "test"
        
        extractRecipeListData.update(recipe)
    }
}
