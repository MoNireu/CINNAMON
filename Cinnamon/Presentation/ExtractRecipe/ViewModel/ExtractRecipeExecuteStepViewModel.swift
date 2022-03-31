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
    
    let step: RecipeStep
    @Published var timeRemaining: Int
    @Published var countDownCompleted: Bool = false
    
    init(step: RecipeStep) {
        print("Log -", #fileID, #function, #line)
        self.step = step
        self.timeRemaining = 0
    }
    
    deinit {
        print("Log -", #fileID, #function, #line)
    }
    
    func onAppear() {
        timeRemaining = step.extractTime
        setTimer()
    }
    
    private func setTimer() {
        Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                print("Log -", #fileID, #function, #line)
                self?.timeRemaining -= 1
                if self?.timeRemaining == 0 {
                    self?.countDownCompleted = true
                }
            }
            .store(in: &cancellableBag)
    }
    
    
}
