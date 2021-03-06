//
//  ExtractRecipeListViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/11.
//

import Foundation
import SwiftUI
import Combine

class ExtractRecipeListViewModel: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    private var usecase: ExtractRecipeListUseCase
    @Published var recipes: [ExtractRecipe] = []
    @Published var selectedExtractType: ExtractType = .espresso
    @Published var isEditing: Bool = false
    @Published var selectedRecipe = Set<UUID>()
    @Published var isRecipeEmpty: Bool = false
    
    // CreateExtractRecipe
    @Published var isCreateRecipeShowing: Bool = false
    @Published var createdRecipe: ExtractRecipe? = nil
    
    init(usecase: ExtractRecipeListUseCase) {
        print("Log -", #fileID, #function, #line)
        self.usecase = usecase
        
        addSubscriptions()
    }
    
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func onAppear() {
        print("Log -", #fileID, #function, #line)
        usecase.requestFetchFromRepository()
    }
    
    func recipeCreated() -> Bool {
        if createdRecipe != nil { return true }
        else { return false }
    }
    
    func showCreateRecipeView() {
        isCreateRecipeShowing = true
    }
    
    func dismissCreateRecipeView() {
        isCreateRecipeShowing = false
    }
    
    func deleteRecipe(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        usecase.removeRecipe(recipes[index])
    }
    
    
    // MARK: - Private Functions
    private func addSubscriptions() {
        reloadOnRecipesChange()
        reloadRecipesOnPickerChange()
        checkRecipeEmptyOnRecipeReload()
        resetSelectedRecipesOnEditFinish()
        showEditStepOnCreateRecipeComplete()
    }
    
    
    private func reloadOnRecipesChange() {
        usecase.getExtractRecipeList
            .assign(to: &$recipes)
    }
    
    private func reloadRecipesOnPickerChange() {
        $selectedExtractType.sink { [weak self] extractType in
            self?.usecase.changeExtractTypeAndRelod(extractType)
        }
        .store(in: &cancellableBag)
    }
    
    private func checkRecipeEmptyOnRecipeReload() {
        $recipes
            .map({$0.isEmpty})
            .assign(to: &$isRecipeEmpty)
    }
    
    private func resetSelectedRecipesOnEditFinish() {
        $isEditing
            .map({!$0})
            .sink { [weak self] editingFinished in
                if editingFinished { self?.selectedRecipe = Set<UUID>() }
            }
            .store(in: &cancellableBag)
    }
    
    private func showEditStepOnCreateRecipeComplete() {
        usecase.getCreatedRecipe.sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                //TODO: ?????? ?????? Alert
                print(error.localizedDescription)
            }
        } receiveValue: { [weak self] recipe in
            self?.createdRecipe = recipe
        }
        .store(in: &cancellableBag)
    }
}
