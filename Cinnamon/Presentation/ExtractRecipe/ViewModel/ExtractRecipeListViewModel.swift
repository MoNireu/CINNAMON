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
    private var cancelBag = Set<AnyCancellable>()
    @Published private var usecase: ExtractRecipeListUseCase
    @Published var recipes: [ExtractRecipe] = []
    @Published var selectedExtractType: ExtractType = .espresso
//    @Published var editingMode: EditMode = .inactive
    @Published var isEditing: Bool = false
    @Published var selectedRecipe = Set<UUID>()
    
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
    
    
    // MARK: - Private Functions
    private func addSubscriptions() {
        reloadOnRecipesChange()
        reloadRecipesOnPickerChange()
        resetSelectedRecipesOnEditFinish()
    }
    
    
    private func reloadOnRecipesChange() {
        usecase.getExtractRecipeList
            .assign(to: &$recipes)
    }
    
    private func reloadRecipesOnPickerChange() {
        $selectedExtractType.sink { [weak self] extractType in
            self!.usecase.requestGetFromRepositoryCache(extractMethod: extractType)
        }
        .store(in: &cancelBag)
    }
    
    private func resetSelectedRecipesOnEditFinish() {
        $isEditing
            .map({!$0})
            .sink { [weak self] editingFinished in
                if editingFinished { self!.selectedRecipe = Set<UUID>() }
            }
            .store(in: &cancelBag)
    }
}
