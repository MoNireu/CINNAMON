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
    @Published var prepareSecond: Int = 3
    @Published var isPrepareCountDownShowing: Bool = false
    @Published var scaleTest: Float = 1.0
    @Published var opacityTest: Float = 1.0
    
    init(recipe: ExtractRecipe) {
        self.recipe = recipe
        self.moveToNextPageOnCountDownComplete()
    }
    deinit {
        print("Log -", #fileID, #function, #line)
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
    
    func startPrepareTimer() {
        prepareSecond = 3
        isPrepareCountDownShowing = true
        let timer = Timer.publish(every: 1, on: .main, in: .common)
        timer.autoconnect()
            .sink { [weak self] _ in
                print("Log -", #fileID, #function, #line)
                self?.prepareSecond -= 1
                if self?.prepareSecond == 0 {
                    self?.isPrepareCountDownShowing = false
                    timer.connect().cancel()
                    self?.moveToNextPage()
                }
            }
            .store(in: &cancellableBag)
    }
    
    func moveToNextPage() {
        guard pageIndex != recipe.steps.count else { return }
        pageIndex += 1
    }
    
    func moveToPreviousPage() {
        guard pageIndex != 0 else { return }
        pageIndex -= 1
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

