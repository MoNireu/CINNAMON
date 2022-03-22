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
            ExtractRecipe(title: "에스프레소 레시피 3",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 4",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 5",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 6",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 7",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 8",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
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
            ExtractRecipe(title: "에스프레소 레시피 3",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 4",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 5",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 6",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 7",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          steps: [
                            RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                            RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                            RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                        ]),
            ExtractRecipe(title: "에스프레소 레시피 8",
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

struct ExtractRecipe: Identifiable {
    var id: UUID
    var title: String
    var description: String
    var extractType: ExtractType
    var totalExtractTime: Int
    var date: Date
    var beanAmount: Float
    var steps: [RecipeStep]
    
    init(title: String,
         description: String,
         extractType: ExtractType,
         totalExtractTime: Int,
         beanAmount: Float,
         steps: [RecipeStep])
    {
        self.id = UUID()
        self.title = title
        self.description = description
        self.extractType = extractType
        self.totalExtractTime = totalExtractTime
        self.beanAmount = beanAmount
        self.steps = steps
        date = Date()
    }
    
    mutating func addNewStep() {
        steps.append(RecipeStep(title: "", description: "", waterAmount: nil, extractTime: 0))
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
