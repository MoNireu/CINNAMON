//
//  ExtractRecipeDetailViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/16.
//

import Foundation
import Combine

class ExtractRecipeDetailViewModel: ObservableObject {
    @Published var beanAmount: Float?
    @Published var recipeSteps: [RecipeDetail] = [
        RecipeDetail(title: "뜸 들이기", description: nil, waterAmount: 40, extractTime: 60),
        RecipeDetail(title: "1차 푸어링", description: nil, waterAmount: 80, extractTime: 60),
        RecipeDetail(title: "2차 푸어링", description: nil, waterAmount: 40, extractTime: 40)
    ]
}
