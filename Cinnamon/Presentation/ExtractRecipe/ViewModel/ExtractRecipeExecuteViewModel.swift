//
//  ExtractRecipeExecuteViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import Foundation
import Combine

class ExtractRecipeExecuteViewModel: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    
    let recipe: ExtractRecipe
    @Published var pageIndex: Int = 0
    @Published var countDownDidComplete: Bool = false
    
    init(recipe: ExtractRecipe) {
        self.recipe = recipe
        self.moveToNextPageOnCountDownComplete()
    }
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func moveToPreviousPage() {
        guard pageIndex != 0 else { return }
        pageIndex -= 1
    }
    
    func moveToNextPage() {
        guard pageIndex != recipe.steps.count else { return }
        pageIndex += 1
    }
    
    private func moveToNextPageOnCountDownComplete() {
        $countDownDidComplete.sink { [weak self] didComplete in
            if didComplete {
                self?.moveToNextPage()
                self?.countDownDidComplete = false
            }
        }
        .store(in: &cancellableBag)
    }
    
    func getTopBarTitle() -> String {
        if pageIndex == 0 {
            return "총 \(recipe.steps.count)단계"
        }
        else {
            return "단계 ( \(pageIndex) / \(recipe.steps.count) )"
        }
    }
}

