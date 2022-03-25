//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeDetailView: View {
    @StateObject var viewModel: ExtractRecipeDetailViewModel
    
    init(recipe: ExtractRecipe) {
        self._viewModel = .init(wrappedValue: ExtractRecipeDetailViewModel(recipe: recipe))
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("원두 용량 : ")
                TextField("0g", value: $viewModel.recipe.beanAmount, format: .number)
            }
            .font(.system(.title2))
            .padding()
            
            
            ReusableView
                .navigationTitle(viewModel.recipe.title)
                .navigationBarTitleDisplayMode(.inline)
                .listStyle(.plain)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button {
                            if viewModel.isRecipeEditing { viewModel.completeEditing() }
                            else { viewModel.startEditing() }
                        } label: {
                            Text(viewModel.isRecipeEditing ? "완료" : "편집")
                        }
                        .disabled(viewModel.isStepEditing)
                    }
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("완료") {
                                viewModel.sendStopFocus()
                            }
                        }
                    }
                }
        }
        .popup(isPresented: $viewModel.isPickerShowing) {
            BottomPopupView(isPresented: $viewModel.isPickerShowing) {
                MinuteSecondPicker(timeInt: $viewModel.recipe.steps[viewModel.selectedStepIndex].extractTime,
                                   isShowing: $viewModel.isPickerShowing)
            }
        }
    }
}

extension ExtractRecipeDetailView {
    
    @ViewBuilder var ReusableView: some View {
        if viewModel.isRecipeEditing {
            AnyView(ListView)
        }
        else {
            AnyView(ScrollView)
        }
    }
    
    @ViewBuilder var ListView: some View {
        List {
            RecipeStepCell
            AddNewStepButton
        }
        .environment(\.editMode, viewModel.isRecipeEditing ? .constant(.active) : .constant(.inactive))
    }
    
    @ViewBuilder var ScrollView: some View {
        SwiftUI.ScrollView {
            RecipeStepCell
        }
    }
    
    @ViewBuilder var RecipeStepCell: some View {
        ForEach($viewModel.recipe.steps) { $step in
            ExtractRecipeDetailCell(step: $step,
                                    viewModel: self.viewModel)
            .padding(.vertical, -4)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 3.5, leading: 0, bottom: 3.5, trailing: 0))
        }
        .onMove(perform: viewModel.moveSteps)
    }
    
    
    @ViewBuilder var AddNewStepButton: some View {
        HStack {
            Spacer()
            Image(systemName: "plus")
                .font(.system(.title))
                .padding()
            Spacer()
        }
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 5.0)
        }
        .padding()
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
        .onTapGesture {
            viewModel.addNewStep()
        }
    }
}

struct ExtractRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ExtractRecipe(title: "브루잉 레시피 2",
                                   description: "1분 30초 브루잉 레시피",
                                   extractType: .brew,
                                   totalExtractTime: 90,
                                   beanAmount: 20.0,
                                   steps: [
                                     RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                                     RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                     RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                                   ])
        ExtractRecipeDetailView(recipe: recipe)
    }
}
