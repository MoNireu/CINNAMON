//
//  ExtractRecipeExecute.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/31.
//

import SwiftUI

struct ExtractRecipeExecute: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExtractRecipeExecuteViewModel
    
    init(recipe: ExtractRecipe) {
        self._viewModel = .init(initialValue: ExtractRecipeExecuteViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(.linear)
            
            TopBarItemsView
            
            TabView(selection: $viewModel.pageIndex) {
                ExecuteStartView.tag(0)
                ForEach(1..<viewModel.recipe.steps.count+1, id: \.self) { index in
                    ExecuteStepView.tag(index)
                }
            }
            .tabViewStyle(.page)
            .animation(.default, value: viewModel.pageIndex)
            
            BottomBarItemsView
        }
        .onChange(of: viewModel.pageIndex) { newValue in
            print("Log -", #fileID, #function, #line, newValue)
        }
    }
}

extension ExtractRecipeExecute {
    
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
            Text("단계 ( 1 / 3 )")
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
                Text(viewModel.recipe.description)
                Text(String(format: "%0.1fg", viewModel.recipe.beanAmount))
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Text(viewModel.recipe.totalExtractTime.toMinuteString())
                    .font(.system(size: 100))
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                }
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
    
    @ViewBuilder var ExecuteStepView: some View {
        VStack {
            VStack {
                Text(viewModel.currentStep.title)
                    .font(.title)
                    .bold()
                Spacer()
                Text(viewModel.currentStep.extractTime.toMinuteString())
                    .font(.system(size: 100))
                
                HStack {
                    Rectangle()
                        .frame(width: 300, height: 3)
                }
                .padding(.top, -30)
                
                Text(String(format: "%0.1fml", viewModel.currentStep.waterAmount!))
                    .font(.largeTitle)
                Spacer()
                    .visibility(viewModel.currentStep.description.isEmpty ? .visible : .gone)
            }
            .frame(maxHeight: .infinity)
            
            VStack {
                Spacer()
                Text(viewModel.currentStep.description)
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)
                    .padding()
                Spacer()
            }
            .visibility(viewModel.currentStep.description.isEmpty ? .gone : .visible)
            .frame(maxHeight: .infinity)
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
            
            Button("시작") { viewModel.moveToNextPage() }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
                .padding()
                .visibility(viewModel.pageIndex == 0 ? .visible : .gone)
        }
    }
}

struct ExtractRecipeExecute_Previews: PreviewProvider {
    static var previews: some View {
        
        let recipe = ExtractRecipeDummyData.extractRecipeList[0]
        ExtractRecipeExecute(recipe: recipe)
    }
}
