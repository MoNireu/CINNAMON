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

struct ExtractRecipe: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var extractType: ExtractType
    var totalExtractTime: Int
    var date: Date
    var beanAmount: Float
    var steps: [RecipeStep]
}

struct RecipeStep: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var waterAmount: Float?
    var extractTime: Int
}
