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
    var extractRecipeListData: ExtractRecipeStore
    @Published var selectedExtractType: ExtractType = .espresso
    @Published var editingMode: EditMode = .inactive
    @Published var selectedRecipe = Set<UUID>()
    @Published var filteredRecipeList: [ExtractRecipe] = []
    
    init(extractRecipeListData: ExtractRecipeStore) {
        self.extractRecipeListData = extractRecipeListData
        refreshFilteredRecipeList()
    }
    
    func refreshFilteredRecipeList() {
        filteredRecipeList = extractRecipeListData.getRecipeListByExtractType(self.selectedExtractType)
    }
    
    func getExtractRecipeListData() -> ExtractRecipeStore {
        return extractRecipeListData
    }
    
}
