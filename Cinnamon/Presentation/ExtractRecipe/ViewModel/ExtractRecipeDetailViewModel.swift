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
    private var usecase: ExtractRecipeDetailUseCase!
    @Published var recipe: ExtractRecipe
    @Published var isEditing: Bool = false
    @Published var isPickerShowing: Bool = false
    @Published var selectedStepIndex: Int = 0
    
    init(recipe: ExtractRecipe) {
        print("Log -", #fileID, #function, #line)
        self.recipe = recipe
    }
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func onAppear() {
        print("Log -", #fileID, #function, #line)
        self.usecase = ExtractRecipeDetailUseCase(recipeId: recipe.id)
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
    
    func moveSteps(from source: IndexSet, to destination: Int) {
        recipe.steps.move(fromOffsets: source, toOffset: destination)
        self.objectWillChange.send()
    }
}
