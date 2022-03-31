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
    @Published var showBaseInfo: Bool = false
    @Published var isRecipeEditing: Bool = false
    @Published var isPickerShowing: Bool = false
    @Published var isRecipeExecuteShowing: Bool = false
    
    // ExtractRecipeDetailCell
    @Published var selectedStepIndex: Int = 0
    @Published var isStepEditing: Bool = false
    @Published var stopFocus: Bool = false

    
    init(recipe: ExtractRecipe) {
        print("Log -", #fileID, #function, #line)
        self.recipe = recipe
        self.usecase = ExtractRecipeDetailUseCase(recipeId: recipe.id)
        self.reloadOnRecipesChange()
        
        if recipe.steps.isEmpty {
            self.addNewStep()
            self.isRecipeEditing = true
        }
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
        isRecipeEditing = true
    }
    
    func completeEditing() {
        setTotalExtractTime()
        usecase.updateRecipe(recipe)
        isRecipeEditing = false
    }
    
    private func setTotalExtractTime() {
            var totalExtractTime = 0
            for steps in recipe.steps {
                totalExtractTime += steps.extractTime
            }
            recipe.totalExtractTime = totalExtractTime
    }
        
    
    func checkStepValid(_ step: RecipeStep) {
        print("Log -", #fileID, #function, #line)
        if !step.title.isEmpty,
           step.waterAmount != nil,
           step.waterAmount != 0,
           step.extractTime != 0 {
            isStepEditing = false
        }
        else {
            isStepEditing = true
        }
    }
    
    // MARK: - Cell Functions
    func moveStep(from source: IndexSet, to destination: Int) {
        recipe.steps.move(fromOffsets: source, toOffset: destination)
        self.objectWillChange.send()
    }
    
    func deleteStep(at index: IndexSet) {
        recipe.steps.remove(at: index.first!)
    }
    
    func showTimePicker(step: RecipeStep) {
        guard let stepIndex = getStepIndex(step: step) else {
            print("Log -", #fileID, #function, #line, "Failed!")
            return
        }
        selectedStepIndex = stepIndex
        isPickerShowing = true
    }
    
    func getSelectedStep() -> Binding<RecipeStep> {
        return .init { [weak self] in
            self!.recipe.steps[self!.selectedStepIndex]
        } set: { [weak self] recipe in
            guard let self = self else { return }
            self.recipe.steps[self.selectedStepIndex] = recipe
        }
    }
    
    func getStepIndex(step: RecipeStep) -> Int? {
        return recipe.steps.firstIndex(where: { $0.id == step.id })
    }
    
    func sendStopFocus() {
        self.stopFocus = true
        self.isStepEditing = false
    }
}
