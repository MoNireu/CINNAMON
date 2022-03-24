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
                            if viewModel.isEditing { viewModel.completeEditing() }
                            else { viewModel.startEditing() }
                        } label: {
                            Text(viewModel.isEditing ? "완료" : "편집")
                        }
                    }
                }
        }
        .popup(isPresented: $viewModel.isPickerShowing) {
            BottomPopupView(isPresented: $viewModel.isPickerShowing) {
                MinuteSecondPicker(timeInt: $viewModel.recipe.steps[viewModel.selectedStepIndex].extractTime, isShowing: $viewModel.isPickerShowing)
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
    
//    private func getCellPositionByIndex(_ index: Int) -> CellPosition {
//        if index == 0 {
//            return .first
//        }
//        else if index == viewModel.recipe.steps.count - 1 {
//            return .last
//        }
//        else {
//            return .middle
//        }
//    }
    
}

extension ExtractRecipeDetailView {
    
    @ViewBuilder var ReusableView: some View {
        if viewModel.isEditing {
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
        .environment(\.editMode, viewModel.isEditing ? .constant(.active) : .constant(.inactive))
    }
    
    @ViewBuilder var ScrollView: some View {
        SwiftUI.ScrollView {
            RecipeStepCell
        }
    }
    
    @ViewBuilder var RecipeStepCell: some View {
        ForEach($viewModel.recipe.steps) { $step in
            EmptyView()
//            let index = viewModel.recipe.getStepIndex(step: step)
//            ExtractRecipeDetailCell(
//                viewModel: ExtractRecipeDetailCellViewModel(
//                    recipe: viewModel.recipe,
//                    stepInfo: viewModel.recipe.steps[index],
//                    stepIndex: index,
//                    selectedStepIndex: viewModel.selectedStepIndex,
//                    isPickerShowing: viewModel.isPickerShowing,
//                    isParentEditing: viewModel.isEditing))
//            .environmentObject(viewModel.recipe)
            
            //            ExtractRecipeDetailCell(cellPosition: getCellPositionByIndex(index),
            //                                    stepInfo: $step,
            //                                    stepIndex: index,
            //                                    selectedStepIndex: $viewModel.selectedStepIndex,
            //                                    isPickerShowing: $viewModel.isPickerShowing,
            //                                    isParentEditing: viewModel.isEditing)
            
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
