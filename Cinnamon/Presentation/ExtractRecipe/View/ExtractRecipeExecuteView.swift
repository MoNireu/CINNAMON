//
//  ExtractRecipeExecuteView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import SwiftUI

struct ExtractRecipeExecuteView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ExtractRecipeExecuteViewModel
    
    init(recipe: ExtractRecipe) {
        self._viewModel = .init(wrappedValue: ExtractRecipeExecuteViewModel(recipe: recipe))
    }
    
    var body: some View {
        ZStack {
            VStack {
                ProgressView(value: Float(viewModel.pageIndex),
                             total: Float(viewModel.recipe.steps.count))
                    .progressViewStyle(.linear)
                    .animation(.default, value: viewModel.pageIndex)
                
                TopBarItemsView
                
                TabView(selection: $viewModel.pageIndex) {
                    ExecuteStartView
                    
                    ForEach(1..<viewModel.recipe.steps.count+1, id: \.self) { index in
                        ExtractRecipeExecuteStepView(countCompleted: $viewModel.countDownDidComplete,
                                                     step: viewModel.recipe.steps[index-1],
                                                     currentPage: $viewModel.pageIndex,
                                                     stepIndex: index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.default, value: viewModel.pageIndex)
                
                BottomBarItemsView
            }
            .onChange(of: viewModel.pageIndex) { newValue in
                print("Log -", #fileID, #function, #line, newValue)
            }
            
            PrepareTimerView
            
        }
    }
}

extension ExtractRecipeExecuteView {
    
    @ViewBuilder var TopBarItemsView: some View {
        HStack {
            Button {
                self.dismiss()
            } label: {
                Image(systemName: "x.circle.fill")
                    .tint(.gray)
                    .font(.system(size: 25))
            }
            .padding()
            Spacer()
            Text(viewModel.getTopBarTitle())
            Spacer()
            Button {
                //TODO: 진동 제어
            } label: {
                Image(systemName: "iphone.radiowaves.left.and.right")
                    .tint(.gray)
                    .font(.system(size: 25))
            }
            .padding()
        }
    }
    
    
    @ViewBuilder var ExecuteStartView: some View {
        VStack {
            Spacer()
            
            VStack {
                Text(viewModel.recipe.title)
                    .font(.title)
                    .bold()
                Text(viewModel.recipe.description)
                    .font(.title3)
                Text(String(format: "%0.1fg", viewModel.recipe.beanAmount))
                    .font(.title3)
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                HStack {
                    Group {
                        Text(String(format: "%0.2d",
                                    TimeConvertUtil.shared.getMinuteSecondStringByTimeInt(viewModel.recipe.totalExtractTime).minute))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text(":")
                            .fixedSize()
                        
                        Text(String(format: "%0.2d",
                                    TimeConvertUtil.shared.getMinuteSecondStringByTimeInt(viewModel.recipe.totalExtractTime).second))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    }
                    .font(.system(size: 100))
                }
                
                Rectangle()
                    .frame(width: 300, height: 3)
                    .padding(.top, -30)
                
                Text("20ml")
                    .font(.largeTitle)
            }
            .frame(maxHeight: .infinity)
            .padding()
            
            Spacer()
                .frame(maxHeight: .infinity)
            
            Spacer()
        }
    }
    
    
    @ViewBuilder var BottomBarItemsView: some View {
        ZStack {
            HStack {
                Button("이전 단계") { viewModel.moveToPreviousPage() }
                    .padding()
                Spacer()
                Button("다음 단계") { viewModel.moveToNextPage() }
                    .padding()
            }
            
            Button {
                viewModel.startPrepareTimer()
            } label: {
                Text("시작")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
                    .padding()
                    .visibility(viewModel.pageIndex == 0 ? .visible : .gone)
            }
                
        }
    }
    
    @ViewBuilder var PrepareTimerView: some View {
        Text("\(viewModel.prepareSecond)")
            .font(.system(size: 80))
            .scaleEffect(CGFloat(viewModel.scaleTest))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                       value: viewModel.scaleTest)
            .opacity(Double(viewModel.opacityTest))
            .animation(.easeInOut(duration: 0.5).delay(0.5).repeatForever(autoreverses: false),
                       value: viewModel.opacityTest)
            .frame(width: 200, height: 200, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 5)
            }
            .visibility(viewModel.isPrepareCountDownShowing ? .visible : .gone)
            .onAppear {
                viewModel.scaleTest = 1.5
                viewModel.opacityTest = 0.0
            }
            .onDisappear {
                viewModel.scaleTest = 1.0
                viewModel.opacityTest = 1.0
            }
    }
}

struct ExtractRecipeExecute_Previews: PreviewProvider {
    static var previews: some View {
        
        let recipe = ExtractRecipeDummyData.extractRecipeList[0]
        ExtractRecipeExecuteView(recipe: recipe)
    }
}
