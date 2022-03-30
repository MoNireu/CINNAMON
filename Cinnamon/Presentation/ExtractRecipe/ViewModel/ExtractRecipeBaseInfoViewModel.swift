//
//  CreateExtractRecipeViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/29.
//

import Foundation
import Combine

enum ExtractRecipeBaseInfoViewMode {
    case create
    case read
    case update
}

class ExtractRecipeBaseInfoViewModel: ObservableObject {
    private let usecase = ExtractRecipeBaseInfoUseCase()
    
    private var recipe: ExtractRecipe?
    let viewMode: ExtractRecipeBaseInfoViewMode
    let extractType: ExtractType
    
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var beanAmount: Float?
    @Published var beanAmountText: String = ""
    @Published var isAllFieldValid: Bool = false
    @Published var isAlertShowing: Bool = false
    @Published var dismiss = false
    
    
    /// 레시피 생성 모드 Initializer
    /// - Parameter extractType: 추출 타입.
    init(extractType: ExtractType) {
        self.viewMode = .create
        self.extractType = extractType
        self.recipe = nil
    }
    
    
    ///  레시피 기본정보 읽기 / 수정 모드 Initializer
    /// - Parameters:
    ///   - recipe: 수정 및 읽을 레시피
    ///   - viewMode: 수정 및 읽기 모드 선택
    init(recipe: ExtractRecipe, viewMode: ExtractRecipeBaseInfoViewMode) {
        self.recipe = recipe
        self.viewMode = viewMode
        self.extractType = recipe.extractType
        self.title = recipe.title
        self.description = recipe.description
        self.beanAmount = recipe.beanAmount
        self.beanAmountText = String(format: "%.1f", recipe.beanAmount) + "g"
        checkIfAllFieldValid()
    }
    
    func createRecipe() {
        let newRecipe = ExtractRecipe(title: title,
                                      description: description,
                                      extractType: extractType,
                                      beanAmount: beanAmount!)
        usecase.addNewRecipe(newRecipe)
        dismissView()
    }
    
    func updateRecipe() {
        recipe!.title = title
        recipe!.description = description
        recipe!.beanAmount = beanAmount!
        usecase.updateRecipe(recipe!)
        dismissView()
    }
    
    func dismissView() {
        dismiss = true
    }
    
    func checkIfAllFieldValid() {
        isAllFieldValid = !title.isEmpty && beanAmount != nil
    }
    
    func formatBeanAmountText(field: ExtractRecipeBaseInfoFocusedField?) {
        guard field != .beanAmount else {return}
        guard !beanAmountText.isEmpty else {return}
        if beanAmountText.doesMatch(pattern: "^[0-9.]*$") {
            beanAmount = Float(beanAmountText)
            beanAmountText += "g"
        }
        else if beanAmountText.last! == "g" {
            var gramRemovedBeanAmountText = beanAmountText
            gramRemovedBeanAmountText.removeLast()
            beanAmount = Float(gramRemovedBeanAmountText)
        }
        else {
            beanAmountText = ""
            isAlertShowing = true
        }
    }
    
    func getNavigationTitle() -> String {
        switch viewMode {
        case .create:
            return "\(extractType.rawValue) 레시피 생성"
        case .read:
            return "레시피 기본 정보"
        case .update:
            return "레시피 기본 정보 편집"
        }
    }
    
    func isViewReadMode() -> Bool {
        return viewMode == .read ? true : false
    }
}
