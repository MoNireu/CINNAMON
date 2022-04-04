//
//  ExtractRecipeDummyData.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import Foundation

enum ExtractRecipeDummyData {
    static let extractRecipeList = [
        ExtractRecipe(title: "에스프레소 레시피 1",
                      description: "1분 에스프레소 레시피",
                      extractType: .espresso,
                      beanAmount: 20.0,
                      steps: [
                        RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                        RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                        RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                      ]),
        ExtractRecipe(title: "에스프레소 레시피 2",
                      description: "1분 에스프레소 레시피",
                      extractType: .espresso,
                      beanAmount: 20.0,
                      steps: [
                        RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                        RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                        RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                      ]),
        ExtractRecipe(title: "브루잉 레시피 1",
                      description: "1분 브루잉 레시피",
                      extractType: .brew,
                      beanAmount: 20.0,
                      steps: [
                        RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 3),
                        RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 3),
                        RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 3)
                      ]),
        ExtractRecipe(title: "브루잉 레시피 2",
                      description: "1분 브루잉 레시피",
                      extractType: .brew,
                      beanAmount: 20.0,
                      steps: [
                        RecipeStep(title: "뜸 들이기", description: "약 60초 동안 뜸을 들여줍니다.", waterAmount: 40, extractTime: 60),
                        RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                        RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                      ]),
    ]
}
