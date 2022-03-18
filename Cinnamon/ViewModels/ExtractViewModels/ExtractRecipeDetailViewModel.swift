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
    @Published var extractRecipeStore: ExtractRecipeStore
    @Published var recipe: ExtractRecipe
    var index: Int {
        extractRecipeStore.list.firstIndex(where: {$0.id == recipe.id})!
    }
//    @Published var recipeSteps: [RecipeStep] = [
//        RecipeStep(title: "뜸 들이기", description: nil, waterAmount: 40, extractTime: 60),
//        RecipeStep(title: "1차 푸어링", description: nil, waterAmount: 80, extractTime: 60),
//        RecipeStep(title: "2차 푸어링", description: nil, waterAmount: 40, extractTime: 40)
//    ]
    
    init(extractRecipeStore: ExtractRecipeStore, recipe: ExtractRecipe) {
        self.extractRecipeStore = extractRecipeStore
        self.recipe = recipe
    }
    
    func completeEditing() {
        recipe.title = "Test"
        extractRecipeStore.update(recipe)
        extractRecipeStore.objectWillChange.send()
    }
}
