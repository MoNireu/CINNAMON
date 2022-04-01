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
            .overlay {
                PrepareTimerView
            }
            .alert(isPresented: $viewModel.isExecuteCompleteMessageShowing) {
                Alert(title: Text("레시피 실행 완료"),
                      message: Text("레시피 실행이 완료 되었습니다."),
                      dismissButton: .default(Text("확인")) { self.dismiss() })
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
                    .visibility(viewModel.isLastPage() ? .invisible : .visible)
            }
            .visibility(viewModel.isFirstPage() ? .gone : .visible)
            
            Button {
                viewModel.startPrepareTimer()
            } label: {
                Text("시작")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(viewModel.isPrepareCountDownShowing ? .gray : .blue))
                    .padding()
                    .visibility(viewModel.isFirstPage() ? .visible : .gone)
            }
            .disabled(viewModel.isPrepareCountDownShowing ? true : false)
                
        }
    }
    
    @ViewBuilder var PrepareTimerView: some View {
        Text("\(viewModel.prepareSecond)")
            .font(.system(size: 80))
            .scaleEffect(CGFloat(viewModel.prepareCountDownScale))
            .animation(.linear(duration: 1).repeatForever(autoreverses: false),
                       value: viewModel.prepareCountDownScale)
            .opacity(Double(viewModel.prepareCountDownOpacity))
            .animation(.easeInOut(duration: 0.5).delay(0.5).repeatForever(autoreverses: false),
                       value: viewModel.prepareCountDownOpacity)
            .frame(width: 200, height: 200, alignment: .center)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .shadow(radius: 5)
            }
            .visibility(viewModel.isPrepareCountDownShowing ? .visible : .gone)
            .onChange(of: viewModel.isPrepareCountDownShowing) { showing in
                viewModel.prepareCountDownScale = showing ? 1.5 : 1.0
                viewModel.prepareCountDownOpacity = showing ? 0.0 : 1.0
            }
    }
}

struct ExtractRecipeExecute_Previews: PreviewProvider {
    static var previews: some View {
        
        let recipe = ExtractRecipeDummyData.extractRecipeList[0]
        ExtractRecipeExecuteView(recipe: recipe)
    }
}
