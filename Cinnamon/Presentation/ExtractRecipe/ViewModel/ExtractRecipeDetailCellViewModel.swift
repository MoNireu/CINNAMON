////
////  ExtractRecipeDetailCellViewModel.swift
////  Cinnamon
////
////  Created by MoNireu on 2022/03/22.
////
//
//import Foundation
//import Combine
//import SwiftUI
//
//
//class ExtractRecipeDetailCellViewModel: ObservableObject {
//    @Published var recipe: ExtractRecipe
//    @Published var stepInfo: RecipeStep
//    var stepIndex: Int
//    @Published var selectedStepIndex: Int
//    @Published var isPickerShowing: Bool
//    var isParentEditing: Bool
//
//    @Published var isWaterAmountEditing: Bool = false
//    @Published var isDescriptionShowing: Bool
//    @Published var isDescriptionPlaceHolderVisible: Bool
//
//    init(recipe: ExtractRecipe,
//         stepInfo: RecipeStep,
//         stepIndex: Int,
//         selectedStepIndex: Int,
//         isPickerShowing: Bool,
//         isParentEditing: Bool) {
//        self.recipe = recipe
//        self.stepInfo = stepInfo
//        self.stepIndex = stepIndex
//        self.selectedStepIndex = selectedStepIndex
//        self.isPickerShowing = isPickerShowing
//        self.isParentEditing = isParentEditing
//        self.isDescriptionShowing = isParentEditing
//        self.isDescriptionPlaceHolderVisible = stepInfo.description.isEmpty ? true : false
//    }
//
//
//
//    func getEdgeByCellIndex() -> Edge.Set {
//        switch stepIndex {
//        case 0:
//            return .top
//        case recipe.steps.count - 1:
//            return .bottom
//        default:
//            return .horizontal
//        }
//    }
//}
