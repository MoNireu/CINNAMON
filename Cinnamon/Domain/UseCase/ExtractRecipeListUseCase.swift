//
//  ExtractRecipeListUseCase.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine

class ExtractRecipeListUseCase: ObservableObject {
    private var cancelBag = Set<AnyCancellable>()
    @Published private var repository: ExtractRecipeRepository = ExtractRecipeRepository.shared
    private var extractType: ExtractType = .espresso
    
    var getExtractRecipeList = PassthroughSubject<[ExtractRecipe], Never>()
    
    
    // MARK: - Init
    init() {
        print("Log -", #fileID, #function, #line)
        publishSelectedExtractMethodRecipeList()
    }
    
    func requestFetchFromRepository() {
        print("Log -", #fileID, #function, #line)
        repository.fetch()
    }
    
    func requestGetFromRepositoryCache(extractMethod: ExtractType) {
        print("Log -", #fileID, #function, #line)
        self.extractType = extractMethod
        repository.get()
    }
    
    private func publishSelectedExtractMethodRecipeList() {
        repository.getSubject
            .sink { [weak self] recipeList in
                self!.getExtractRecipeList.send(self!.filterRecipeListByExtractType(recipeList))
            }
            .store(in: &cancelBag)
    }
    
    private func filterRecipeListByExtractType(_ list: [ExtractRecipe]) -> [ExtractRecipe] {
        return list.filter({$0.extractType == self.extractType})
    }
}
