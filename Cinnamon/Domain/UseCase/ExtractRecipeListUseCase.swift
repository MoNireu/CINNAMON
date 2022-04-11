//
//  ExtractRecipeListUseCase.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine

class ExtractRecipeListUseCase: ObservableObject {
    @Published private var repository: ExtractRecipeRepository = ExtractRecipeRepositoryImpl.shared
    private var cancellableBag = Set<AnyCancellable>()
    private var extractType: ExtractType = .espresso
    
    var getExtractRecipeList: AnyPublisher<[ExtractRecipe], Never> {
        repository.getListSubject
            .map { [weak self] recipeList in
                guard let self = self else { return [] }
                return self.filterRecipeListByExtractType(recipeList)
            }
            .eraseToAnyPublisher()
    }
    
    var getCreatedRecipe: AnyPublisher<ExtractRecipe, Error> {
        repository.createdRecipeSubject.eraseToAnyPublisher()
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
                    print("Log -", #fileID, #function, #line, "FetchComplete")
                }
                else {
                    print("Log -", #fileID, #function, #line, "Repository Fetch Failed")
                }
            })
            .store(in: &cancellableBag)
    }
    
    func changeExtractTypeAndRelod(_ extractType: ExtractType) {
        self.extractType = extractType
        self.requestGetFromRepositoryCache()
    }
    
    func requestGetFromRepositoryCache() {
        print("Log -", #fileID, #function, #line)
        repository.get()
    }
    
    func removeRecipe(_ recipe: ExtractRecipe) {
        repository.remove(recipe: recipe)
            .sink { isDeleted in
                if isDeleted { print("Log -", #fileID, #function, #line, "Recipe Deleted")}
                else {print("Log -", #fileID, #function, #line, "Recipe Delete Failed")}
            }
            .store(in: &cancellableBag)
    }
    
    private func filterRecipeListByExtractType(_ list: [ExtractRecipe]) -> [ExtractRecipe] {
        return list.filter({$0.extractType == self.extractType})
    }
}
