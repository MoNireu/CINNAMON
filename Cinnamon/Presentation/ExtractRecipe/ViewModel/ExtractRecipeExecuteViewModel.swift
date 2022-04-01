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
    @Published private(set) var topBarTitle: String = ""
    @Published private(set) var prepareSecond: Int = 3
    @Published private(set) var isPrepareCountDownShowing: Bool = false
    @Published var prepareCountDownScale: Float = 1.0
    @Published var prepareCountDownOpacity: Float = 1.0
    @Published var isExecuteCompleteMessageShowing: Bool = false
    
    init(recipe: ExtractRecipe) {
        self.recipe = recipe
        self.setTopBarTitle()
        self.moveToNextPageOnCountDownComplete()
    }
    deinit {
        print("Log -", #fileID, #function, #line)
        FeedBackUtil.shared.releaseFeedBackGenerator()
    }
    
    private func setTopBarTitle() {
        $pageIndex.sink { [weak self] index in
            guard let self = self else { return }
            
            if self.pageIndex == 0 {
                self.topBarTitle = "총 \(self.recipe.steps.count)단계"
            }
            else {
                self.topBarTitle = "단계 ( \(index) / \(self.recipe.steps.count) )"
            }
        }
        .store(in: &cancellableBag)
    }
    
    private func moveToNextPageOnCountDownComplete() {
        $countDownDidComplete.sink { [weak self] didComplete in
            guard let self = self else { return }
            if didComplete {
                if self.isLastPage() {
                    self.isExecuteCompleteMessageShowing = true
                    FeedBackUtil.shared.haptic(notificationType: .success)
                }
                else {
                    self.moveToNextPage()
                    self.countDownDidComplete = false
                }
            }
        }
        .store(in: &cancellableBag)
    }
    
    func startPrepareTimer() {
        FeedBackUtil.shared.prepareFeedBackGenerator()
        FeedBackUtil.shared.haptic(notificationType: .warning)
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
                else {
                    FeedBackUtil.shared.haptic(notificationType: .warning)
                }
            }
            .store(in: &cancellableBag)
    }
    
    func moveToNextPage() {
        guard !isLastPage() else { return }
        pageIndex += 1
    }
    
    func isLastPage() -> Bool {
        return pageIndex == recipe.steps.count
    }
    
    func moveToPreviousPage() {
        guard !isFirstPage() else { return }
        pageIndex -= 1
    }
    
    func isFirstPage() -> Bool {
        return pageIndex == 0
    }
}

