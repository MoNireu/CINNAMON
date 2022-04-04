//
//  ExtractRecipe.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import Foundation

enum ExtractType: String {
    case espresso = "에스프레소"
    case brew = "브루잉"
}

struct ExtractRecipe: Identifiable {
    var id: UUID = UUID()
    var title: String
    var description: String = ""
    var extractType: ExtractType
    var beanAmount: Float
    var steps: [RecipeStep] = []
    var totalExtractTime: Int {
        var totalTime = 0
        for steps in steps {
            totalTime += steps.extractTime
        }
        return totalTime
    }
    var date: Date = Date.now
}

struct RecipeStep: Identifiable {
    var id: UUID = UUID()
    var title: String = ""
    var description: String = ""
    var waterAmount: Float?
    var extractTime: Int = 0
}
