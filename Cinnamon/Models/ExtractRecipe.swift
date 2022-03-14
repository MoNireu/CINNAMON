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

class ExtractRecipe: Identifiable {
    var id: UUID
    var title: String
    var description: String?
    var extractType: ExtractType
    var totalExtractTime: Int
    var date: Date
    var beanAmount: Float
    var recipeDetail: [RecipeDetail]
    
    init(title: String,
         description: String?,
         extractType: ExtractType,
         totalExtractTime: Int,
         beanAmount: Float,
         recipeDetail: [RecipeDetail])
    {
        self.id = UUID()
        self.title = title
        self.description = description
        self.extractType = extractType
        self.totalExtractTime = totalExtractTime
        self.beanAmount = beanAmount
        self.recipeDetail = recipeDetail
        date = Date()
    }
}

class RecipeDetail {
    var title: String?
    var description: String?
    var waterAmount: Float
    var extractTime: Int
    
    init(title: String?, description: String?, waterAmount: Float, extractTime: Int) {
        self.title = title
        self.description = description
        self.waterAmount = waterAmount
        self.extractTime = extractTime
    }
}
