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
            .sink(receiveValue: { didSuccess in
                if didSuccess {
                    self.requestGetFromRepositoryCache()
                }
                else {
                    print("Log -", #fileID, #function, #line, "Repository Fetch Failed")
                }
            })
            .store(in: &cancelBag)
    }
    
    func changeExtractTypeAndRelod(_ extractType: ExtractType) {
        self.extractType = extractType
        self.requestGetFromRepositoryCache()
    }
    
    func requestGetFromRepositoryCache() {
        print("Log -", #fileID, #function, #line)
        repository.get()
    }
    
    private func publishSelectedExtractMethodRecipeList() {
        repository.getListSubject
            .sink { [weak self] recipeList in
                self!.getExtractRecipeList.send(self!.filterRecipeListByExtractType(recipeList))
            }
            .store(in: &cancelBag)
    }
    
    private func filterRecipeListByExtractType(_ list: [ExtractRecipe]) -> [ExtractRecipe] {
        return list.filter({$0.extractType == self.extractType})
    }
}
