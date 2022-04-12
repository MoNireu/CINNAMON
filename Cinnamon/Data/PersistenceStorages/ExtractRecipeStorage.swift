//
//  PersistenceStorage.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/12.
//

import Foundation
import Combine

enum DAOError: String, Error {
    case fetchFailed = "Error: Fetch Failed"
    case saveFailed = "Error: Save Failed"
    case updateFailed = "Error: Update Failed"
    case deleteFailed = "Error: Delete Failed"
}

protocol ExtractRecipeStorage {
    func fetch() -> Future<[ExtractRecipe], Error>
    func save(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error>
    func update(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error>
    func delete(recipe: ExtractRecipe) -> Future<ExtractRecipe, Error>
}
