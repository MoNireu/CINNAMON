//
//  ExtractRecipeExecuteViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import Foundation
import Combine

class ExtractRecipeExecuteViewModel: ObservableObject {
    let recipe: ExtractRecipe
    @Published var currentStep: RecipeStep
    @Published var pageIndex: Int = 0
    
    init(recipe: ExtractRecipe) {
        self.recipe = recipe
        self.currentStep = recipe.steps[0]
    }
    
    func moveToPreviousPage() {
        pageIndex -= 1
        updateStepInfoViews()
    }
    
    func moveToNextPage() {
        pageIndex += 1
        updateStepInfoViews()
    }
    
    func updateStepInfoViews() {
        guard pageIndex != 0 else { return }
        currentStep = recipe.steps[pageIndex - 1]
    }
}

