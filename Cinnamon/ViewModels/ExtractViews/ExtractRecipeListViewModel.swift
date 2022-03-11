//
//  ExtractRecipeListViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/11.
//

import Foundation
import Combine

class ExtractRecipeListViewModel: ObservableObject {
    @Published var selectedExtractType: ExtractType = .espresso
    @Published var isModifying: Bool = false
    
    var recipeList: [ExtractRecipe] {
        return [
            ExtractRecipe(title: "에스프레소 레시피 1",
                          description: "1분 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          recipeDetail: []),
            ExtractRecipe(title: "에스프레소 레시피 2",
                          description: "1분 30초 에스프레소 레시피",
                          extractType: .espresso,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          recipeDetail: []),
            ExtractRecipe(title: "브루잉 레시피 1",
                          description: "1분 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 60,
                          beanAmount: 20.0,
                          recipeDetail: []),
            ExtractRecipe(title: "브루잉 레시피 2",
                          description: "1분 30초 브루잉 레시피",
                          extractType: .brew,
                          totalExtractTime: 90,
                          beanAmount: 20.0,
                          recipeDetail: [])
        ]
    }
}
