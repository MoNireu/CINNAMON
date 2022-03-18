//
//  ExtractRecipe.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import Foundation

enum ExtractType {
    case espresso
    case brew
}

class ExtractRecipeStore: ObservableObject {
    var list: [ExtractRecipe]
    
    init() {
        list = [
            ExtractRecipe(title: "에스프레소 레시피 1",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          recipeDetail: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 2",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          recipeDetail: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "브루잉 레시피 1",
                          description: "1분 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          recipeDetail: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "브루잉 레시피 2",
                          description: "1분 30초 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          recipeDetail: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ])
        ]
    }
    
    
    func update(_ newRecipe: ExtractRecipe) {
        if let index = list.firstIndex(where: {$0.id == newRecipe.id}) {
            print("Log -", #fileID, #function, #line, "Recipe found!")
            list[index] = newRecipe
        }
    }
    
    func getRecipeListByExtractType(_ extractType: ExtractType) -> [ExtractRecipe] {
        return self.list.filter({$0.extractType == extractType})
    }
}

class ExtractRecipe: Identifiable {
    var id: UUID
    var title: String
    var description: String?
    var extractType: ExtractType
    var totalExtractTime: Int
    var date: Date
    var beanAmount: Float
    var recipeSteps: [RecipeStep]
    
    init(title: String,
         description: String?,
         extractType: ExtractType,
         totalExtractTime: Int,
         beanAmount: Float,
         recipeDetail: [RecipeStep])
    {
        self.id = UUID()
        self.title = title
        self.description = description
        self.extractType = extractType
        self.totalExtractTime = totalExtractTime
        self.beanAmount = beanAmount
        self.recipeSteps = recipeDetail
        date = Date()
    }
}

struct RecipeStep: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var waterAmount: Float?
    var extractTime: Int
    
    init(title: String, description: String, waterAmount: Float?, extractTime: Int) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.waterAmount = waterAmount
        self.extractTime = extractTime
    }
}
