//
//  ExtractRecipeExecuteStepView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import SwiftUI

struct ExtractRecipeExecuteStepView: View {
    @Binding var countCompleted: Bool
    @Binding var currentPage: Int
    @Binding var isFeedBackAllowed: Bool
    var stepIndex: Int
    @StateObject var viewModel: ExtractRecipeExecuteStepViewModel
    
    init(countCompleted: Binding<Bool>,
         step: RecipeStep,
         currentPage: Binding<Int>,
         stepIndex: Int,
         isFeedBackAllowed: Binding<Bool>) {
        self._countCompleted = countCompleted
        self._viewModel = .init(
            wrappedValue: ExtractRecipeExecuteStepViewModel(step: step,
                                                            isFeedBackAllowed: isFeedBackAllowed.wrappedValue))
        self._currentPage = currentPage
        self.stepIndex = stepIndex
        self._isFeedBackAllowed = isFeedBackAllowed
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(viewModel.step.title)
                    .font(.title)
                    .bold()
                Spacer()
                
                HStack {
                    Group {
                        Text(String(format: "%0.2d",
                                    TimeConvertUtil.shared.getMinuteSecondStringByTimeInt(viewModel.timeRemaining).minute))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text(":")
                            .fixedSize()
                        
                        Text(String(format: "%0.2d",
                                    TimeConvertUtil.shared.getMinuteSecondStringByTimeInt(viewModel.timeRemaining).second))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .font(.system(size: 100))
                    .foregroundColor(viewModel.timeRemaining <= 5 ? .red : .black)
                }
                
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                        .padding(.top, -30)
                }
                
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
        .onChange(of: currentPage) { pageIndex in
            if pageIndex == stepIndex {
                viewModel.setTimerAndFeedBack()
            }
            else {
                viewModel.stopTimer()
            }
        }
        .onChange(of: isFeedBackAllowed) { feedBackAllowed in
            viewModel.isFeedBackAllowed = feedBackAllowed
        }
    }
}

struct ExtractRecipeExecuteStepView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ExtractRecipeDummyData.extractRecipeList[0]
        ExtractRecipeExecuteStepView(countCompleted: .constant(false),
                                     step: recipe.steps[0],
                                     currentPage: .constant(1),
                                     stepIndex: 0,
                                     isFeedBackAllowed: .constant(true))
    }
}
