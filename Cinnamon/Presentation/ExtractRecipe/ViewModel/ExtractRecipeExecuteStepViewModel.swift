//
//  ExtractRecipeExecuteStepViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import Foundation
import Combine
import UIKit

class ExtractRecipeExecuteStepViewModel: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    private var timer = Timer.publish(every: 1, on: .main, in: .common)
    let step: RecipeStep
    @Published var timeRemaining: Int
    @Published var countDownCompleted: Bool = false
    
    init(step: RecipeStep) {
        print("Log -", #fileID, #function, #line)
        self.step = step
        print("Log -", #fileID, #function, #line, step.extractTime)
        self.timeRemaining = 0
    }
    
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func setTimerAndFeedBack() {
        print("Log -", #fileID, #function, #line)
        timeRemaining = step.extractTime
        startTimer()
    }
    
    private func startTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.timer.autoconnect()
            .sink { [weak self] _ in
                print("Log -", #fileID, #function, #line)
                guard let self = self else { return }
                self.timeRemaining -= 1
                if self.timeRemaining == 0 {
                    self.stopTimer()
                    self.countDownCompleted = true
                }
                else if self.timeRemaining <= 5 {
                    FeedBackUtil.shared.haptic(notificationType: .warning)
                }
            }
            .store(in: &cancellableBag)
    }
    
    func stopTimer() {
        self.timer.connect().cancel()
    }
}
