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
    @Published var isEditing: Bool = false
    @Published var isPickerShowing: Bool = false
    @Published var selectedStepIndex: Int = 0
    var index: Int {
        extractRecipeStore.list.firstIndex(where: {$0.id == recipe.id})!
    }
    
    init(extractRecipeStore: ExtractRecipeStore, recipe: ExtractRecipe) {
        self.extractRecipeStore = extractRecipeStore
        self.recipe = recipe
        print("Log -", #fileID, #function, #line)
    }
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func addNewStep() {
        recipe.addNewStep()
        self.objectWillChange.send()
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing() {
        recipe.title = "Test"
        extractRecipeStore.update(recipe)
        isEditing = false
        extractRecipeStore.objectWillChange.send()
    }
    
    func moveSteps(from source: IndexSet, to destination: Int) {
        recipe.steps.move(fromOffsets: source, toOffset: destination)
        self.objectWillChange.send()
    }
}
