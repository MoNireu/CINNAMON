//
//  ExtractRecipeRepository.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/23.
//

import Foundation
import Combine


final class ExtractRecipeRepositoryImpl: ObservableObject, ExtractRecipeRepository{
    static let shared: ExtractRecipeRepository = ExtractRecipeRepositoryImpl()
    private let extractReicpeDAO: ExtractRecipeStorage = ExtractRecipeStorageImpl()
    private var cache: [ExtractRecipe]
    private var cancellableBag = Set<AnyCancellable>()
    
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
            var cancellableBag = Set<AnyCancellable>()
            self?.extractReicpeDAO.update(recipe: newRecipe)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Log -", #fileID, #function, #line, "Recipe Updated!")
                        break
                    case .failure(let error):
                        promise(.failure(error))
                        print("Log -", #fileID, #function, #line, error)
                        break
                    }
                }, receiveValue: { result in
                    guard let index = self?.getRecipeIndex(recipe: result)
                    else {
                        print("Log -", #fileID, #function, #line, "Error: Recipe Not Found")
                        promise(.failure(NSError()))
                        return
                    }
                    self?.cache[index] = result
                    self?.get()
                    promise(.success(result))
                })
                .store(in: &cancellableBag)
        }
    }
    
    func remove(recipe: ExtractRecipe) -> Future<Bool, Never> {
        return Future() { [weak self] promise in
            var cancellableBag = Set<AnyCancellable>()
            self?.extractReicpeDAO.delete(recipe: recipe)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("Log -", #fileID, #function, #line, "Recipe removed")
                        promise(.success(true))
                        break
                    case .failure(let error):
                        print("Log -", #fileID, #function, #line, error.localizedDescription)
                        promise(.success(false))
                        break
                    }
                }, receiveValue: { result in
                    guard let recipeIndex = self?.getRecipeIndex(recipe: result)
                    else {
                        print("Log -", #fileID, #function, #line, "Error: Recipe Not Found")
                        return
                    }
                    self?.cache.remove(at: recipeIndex)
                    self?.get()
                })
                .store(in: &cancellableBag)
        }
    }
    
    private func getRecipeIndex(recipe: ExtractRecipe) -> Int? {
        return cache.firstIndex(where: {$0.id == recipe.id})
    }
}
