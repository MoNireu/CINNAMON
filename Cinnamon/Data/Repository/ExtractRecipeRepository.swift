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
    
    var getSubject = PassthroughSubject<[ExtractRecipe], Never>()
    
    private init() {
        cache = []
        print("Log -", #fileID, #function, #line)
    }
    
    func fetch() {
        print("Log -", #fileID, #function, #line)
        cache = [
            ExtractRecipe(title: "에스프레소 레시피 1",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                          ]),
            ExtractRecipe(title: "에스프레소 레시피 2",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                          ]),
            ExtractRecipe(title: "브루잉 레시피 1",
                          description: "1분 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                          ]),
            ExtractRecipe(title: "브루잉 레시피 2",
                          description: "1분 30초 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                          ])
        ]
        get()
    }
    
    func get() {
        print("Log -", #fileID, #function, #line)
        getSubject.send(cache)
    }
    
    func update(_ newRecipe: ExtractRecipe) {
        if let index = cache.firstIndex(where: {$0.id == newRecipe.id}) {
            print("Log -", #fileID, #function, #line, "Recipe found!")
            cache[index] = newRecipe
            self.objectWillChange.send()
        }
    }
    
    func getRecipeListByExtractType(_ extractType: ExtractType) -> [ExtractRecipe] {
        return self.cache.filter({$0.extractType == extractType})
    }
}
