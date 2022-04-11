//
//  ExtractRecipeRepository.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/11.
//

import Foundation
import Combine

protocol ExtractRecipeRepository {
    var getListSubject: PassthroughSubject<[ExtractRecipe], Never> { get set }
    var createdRecipeSubject: PassthroughSubject<ExtractRecipe, Error> { get set }
    func fetch() -> Future<Bool, Never>
    func get()
    func add(newRecipe: ExtractRecipe)
    func update(newRecipe: ExtractRecipe) -> Future<ExtractRecipe, Error>
    func remove(recipe: ExtractRecipe) -> Future<Bool, Never>
}
