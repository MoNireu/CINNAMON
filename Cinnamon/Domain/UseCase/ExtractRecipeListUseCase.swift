//
//  ExtractRecipeListUseCase.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine

class ExtractRecipeListUseCase: ObservableObject {
    @Published private var repository: ExtractRecipeRepository = ExtractRecipeRepository.shared
    private var cancelBag = Set<AnyCancellable>()
    private var extractType: ExtractType = .espresso
    
    var getExtractRecipeList: AnyPublisher<[ExtractRecipe], Never> {
        repository.getListSubject
            .map { [weak self] recipeList in
                guard let self = self else { return [] }
                return self.filterRecipeListByExtractType(recipeList)
            }
            .eraseToAnyPublisher()
    }
    
    
    // MARK: - Init
    init() {
        print("Log -", #fileID, #function, #line)
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
    
    private func filterRecipeListByExtractType(_ list: [ExtractRecipe]) -> [ExtractRecipe] {
        return list.filter({$0.extractType == self.extractType})
    }
}
