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
    private var cancelBag = Set<AnyCancellable>()
    private var usecase: ExtractRecipeDetailUseCase
    @Published var recipe: ExtractRecipe
    @Published var isEditing: Bool = false
    @Published var isPickerShowing: Bool = false
    @Published var selectedStepIndex: Int = 0
    @Published var stopFocus: Bool = false

    
    init(recipe: ExtractRecipe) {
        print("Log -", #fileID, #function, #line)
        self.recipe = recipe
        self.usecase = ExtractRecipeDetailUseCase(recipeId: recipe.id)
        self.reloadOnRecipesChange()
    }
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    private func reloadOnRecipesChange() {
        usecase.getRecipe
            .assign(to: &$recipe)
    }
    
    func addNewStep() {
        usecase.addNewStep(to: recipe)
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing() {
        recipe.title = "Test"
        usecase.updateRecipe(recipe)
        isEditing = false
    }
    
    // MARK: - Cell Functions
    func moveSteps(from source: IndexSet, to destination: Int) {
        recipe.steps.move(fromOffsets: source, toOffset: destination)
        self.objectWillChange.send()
    }
    
    func showTimePicker(step: RecipeStep) {
        guard let stepIndex = getStepIndex(step: step) else {
            print("Log -", #fileID, #function, #line, "Failed!")
            return
        }
        selectedStepIndex = stepIndex
        isPickerShowing = true
    }
    
    func getStepIndex(step: RecipeStep) -> Int? {
        return recipe.steps.firstIndex(where: { $0.id == step.id })
    }
    
    func sendStopFocus() {
        self.stopFocus = true
    }
}
