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
    private var cache: [ExtractRecipe]
    
    var getListSubject = PassthroughSubject<[ExtractRecipe], Never>()
    
    private init() {
        print("Log -", #fileID, #function, #line)
        cache = []
    }
    
    func fetch() -> Future<Bool, Never> {
        return Future() { [weak self] promise in
            print("Log -", #fileID, #function, #line)
            self?.cache = [
                ExtractRecipe(title: "에스프레소 레시피 1",
                              description: "1분 에스프레소 레시피",
                              extractType: .espresso,
                              beanAmount: 20.0,
                              totalExtractTime: 60,
                              steps: [
                                RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                                RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                              ]),
                ExtractRecipe(title: "에스프레소 레시피 2",
                              description: "1분 에스프레소 레시피",
                              extractType: .espresso,
                              beanAmount: 20.0,
                              totalExtractTime: 60,
                              steps: [
                                RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                                RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                              ]),
                ExtractRecipe(title: "브루잉 레시피 1",
                              description: "1분 브루잉 레시피",
                              extractType: .brew,
                              beanAmount: 20.0,
                              totalExtractTime: 60,
                              steps: [
                                RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                                RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                              ]),
                ExtractRecipe(title: "브루잉 레시피 2",
                              description: "1분 브루잉 레시피",
                              extractType: .brew,
                              beanAmount: 20.0,
                              totalExtractTime: 60,
                              steps: [
                                RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                                RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                              ]),
            ]
            promise(.success(true))
        }
    }
    
    func get() {
        print("Log -", #fileID, #function, #line)
        getListSubject.send(cache)
    }
    
    func add(newRecipe: ExtractRecipe) {
        cache.append(newRecipe)
        get()
    }
    
    func add(newStep: RecipeStep, to recipe: ExtractRecipe) {
        
    }
    
    func update(newRecipe: ExtractRecipe) {
        if let index = getRecipeIndex(recipe: newRecipe) {
            cache[index] = newRecipe
            print("Log -", #fileID, #function, #line, "Recipe Updated!")
            self.get()
        }
        else {
            print("Log -", #fileID, #function, #line, "Error: Recipe Not Found")
        }
    }
    
    private func getRecipeIndex(recipe: ExtractRecipe) -> Int? {
        return cache.firstIndex(where: {$0.id == recipe.id})
    }
}
