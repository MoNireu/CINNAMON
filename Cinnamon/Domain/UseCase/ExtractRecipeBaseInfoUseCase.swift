//
//  CreateExtractRecipeUseCase.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/29.
//

import Foundation
import Combine

class ExtractRecipeBaseInfoUseCase {
    private let repository = ExtractRecipeRepository.shared
    
    func addNewRecipe(_ recipe: ExtractRecipe) {
        repository.add(newRecipe: recipe)
        //TODO: Save Recipe
    }
    
    func updateRecipe(_ recipe: ExtractRecipe) {
        repository.update(newRecipe: recipe)
    }
}
