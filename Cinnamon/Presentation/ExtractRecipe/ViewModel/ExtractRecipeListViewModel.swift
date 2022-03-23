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
    @Published var extractRecipeStore: ExtractRecipeStore
    @Published var selectedExtractType: ExtractType = .espresso
    @Published var editingMode: EditMode = .inactive
    @Published var selectedRecipe = Set<UUID>()
    var filteredRecipeList: [ExtractRecipe] {
        extractRecipeStore.getRecipeListByExtractType(self.selectedExtractType)
    }
    
    init(extractRecipeListData: ExtractRecipeStore) {
        self.extractRecipeStore = extractRecipeListData
    }
}
