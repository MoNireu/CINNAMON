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

class ExtractRecipe: ObservableObject, Identifiable {
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
    
    func addNewStep() {
        steps.append(RecipeStep(title: "", description: "", waterAmount: nil, extractTime: 0))
    }
    
    func getStepIndex(step: RecipeStep) -> Int {
        return self.steps.firstIndex(where: {$0.id == step.id})!
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
