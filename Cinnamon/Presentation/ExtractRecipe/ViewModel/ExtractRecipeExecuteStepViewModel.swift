//
//  ExtractRecipeExecuteStepViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import Foundation
import Combine

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
    
    func startTimer() {
        print("Log -", #fileID, #function, #line)
        timeRemaining = step.extractTime
        setTimer()
    }
    
    private func setTimer() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common)
        self.timer.autoconnect()
            .sink { [weak self] _ in
                print("Log -", #fileID, #function, #line)
                self?.timeRemaining -= 1
                if self?.timeRemaining == 0 {
                    self?.stopTimer()
                    self?.countDownCompleted = true
                }
            }
            .store(in: &cancellableBag)
    }
    
    func stopTimer() {
        self.timer.connect().cancel()
    }
}
