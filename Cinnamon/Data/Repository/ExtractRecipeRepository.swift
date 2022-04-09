//
//  ExtractRecipeRepository.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine


class ExtractRecipeRepository: ObservableObject {
    static let shared: ExtractRecipeRepository = ExtractRecipeRepository()
    private var cancellableBag = Set<AnyCancellable>()
    private let extractReicpeDAO = ExtractRecipeDAO()
    private var cache: [ExtractRecipe]
    
    var getListSubject = PassthroughSubject<[ExtractRecipe], Never>()
    var createdRecipeSubject = PassthroughSubject<ExtractRecipe, Error>()
    
    private init() {
        print("Log -", #fileID, #function, #line)
        cache = []
    }
    
    func fetch() -> Future<Bool, Never> {
        return Future() { [weak self] promise in
            var cancellableBag = Set<AnyCancellable>()
            self?.extractReicpeDAO.fetch()
                .sink { completion in
                    switch completion {
                    case .finished:
                        print("Log -", #fileID, #function, #line, "Fetch Completed")
                        promise(.success(true))
                        break
                    case .failure(let error):
                        print("Log -", #fileID, #function, #line, error.localizedDescription)
                        promise(.success(false))
                        break
                    }
                } receiveValue: { result in
                    self?.cache = result
                    self?.get()
                    print("Log -", #fileID, #function, #line, "Retrived Fetch Result")
                }
                .store(in: &cancellableBag)
        }
    }
    
    func get() {
        print("Log -", #fileID, #function, #line)
        getListSubject.send(cache)
    }
    
    func add(newRecipe: ExtractRecipe){
        extractReicpeDAO.save(recipe: newRecipe)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Log -", #fileID, #function, #line, error.localizedDescription)
                    self?.createdRecipeSubject.send(completion: .failure(error))
                    break
                }
            } receiveValue: { [weak self] result in
                self?.cache.append(result)
                self?.get()
                self?.createdRecipeSubject.send(result)
            }
            .store(in: &cancellableBag)
    }
    
    @discardableResult
    func update(newRecipe: ExtractRecipe) -> Future<ExtractRecipe, Error> {
        return Future { [weak self] promise in
            if let index = self?.getRecipeIndex(recipe: newRecipe) {
                self?.cache[index] = newRecipe
                print("Log -", #fileID, #function, #line, "Recipe Updated!")
                promise(.success(newRecipe))
                self?.get()
            }
            else {
                print("Log -", #fileID, #function, #line, "Error: Recipe Not Found")
                promise(.failure(NSError()))
            }
        }
    }
    
    private func getRecipeIndex(recipe: ExtractRecipe) -> Int? {
        return cache.firstIndex(where: {$0.id == recipe.id})
    }
}
