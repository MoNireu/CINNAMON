//
//  ExtractRecipeExecuteStepView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import SwiftUI

struct ExtractRecipeExecuteStepView: View {
    @Binding var countCompleted: Bool
    @ObservedObject var viewModel: ExtractRecipeExecuteStepViewModel
    
    init(countCompleted: Binding<Bool>, step: RecipeStep) {
        self._countCompleted = countCompleted
        self._viewModel = .init(initialValue: ExtractRecipeExecuteStepViewModel(step: step))
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.step.title)
                    .font(.title)
                    .bold()
                Spacer()
                Text(viewModel.timeRemaining.toMinuteString())
                    .font(.system(size: 100))
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                }
                .padding(.top, -30)
                
                Text(String(format: "%0.1fml", viewModel.step.waterAmount!))
                    .font(.largeTitle)
                Spacer()
                    .visibility(viewModel.step.description.isEmpty ? .visible : .gone)
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Spacer()
                Text(viewModel.step.description)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .visibility(viewModel.step.description.isEmpty ? .gone : .visible)
            .frame(maxHeight: .infinity)
        }
        .onReceive(viewModel.$countDownCompleted) { didComplete in
            if didComplete {
                self.countCompleted = true
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ExtractRecipeExecuteStepView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ExtractRecipeDummyData.extractRecipeList[0]
        ExtractRecipeExecuteStepView(countCompleted: .constant(false),
                                     step: recipe.steps[0])
    }
}
