//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeDetailView: View {
    @EnvironmentObject var extractRecipeStore: ExtractRecipeStore
    @ObservedObject var viewModel: ExtractRecipeDetailViewModel
    @State private var isPickerShowing: Bool = false
    @State private var selectedStepIndex: Int = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("원두 용량 : ")
                TextField("0g", value: $viewModel.recipe.beanAmount, format: .number)
            }
            .font(.system(.title2))
            .padding()
            
            
            getReusableViewByEditMode()
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
        .popup(isPresented: $isPickerShowing) {
            BottomPopupView(isPresented: $isPickerShowing) {
                MinuteSecondPicker(timeInt: $viewModel.recipe.steps[selectedStepIndex].extractTime, isShowing: $isPickerShowing)
            }
        }
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
    
    private func getReusableViewByEditMode() -> some View {
        if viewModel.isEditing {
            return AnyView(getListView())
        }
        else {
            return AnyView(getScrollView())
        }
    }
    
    
    private func getListView() -> some View {
        List {
            getEachCell()
            AddNewStepButton
        }
        .environment(\.editMode, viewModel.isEditing ? .constant(.active) : .constant(.inactive))
    }
    
    private func getScrollView() -> some View {
        ScrollView {
            getEachCell()
        }
    }
    
    
    
    private func getEachCell() -> some View {
        ForEach($viewModel.recipe.steps) { $step in
            let index = getStepIndex(step)
            ExtractRecipeDetailCell(cellPosition: getCellPositionByIndex(index),
                                    stepInfo: $step,
                                    stepIndex: index,
                                    selectedStepIndex: $selectedStepIndex,
                                    isPickerShowing: $isPickerShowing,
                                    isParentEditing: viewModel.isEditing)
            .padding(.vertical, -4)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 3.5, leading: 0, bottom: 3.5, trailing: 0))
        }
        .onMove(perform: viewModel.moveSteps)
    }
    
    private func getStepIndex(_ step: RecipeStep) -> Int {
        viewModel.recipe.steps.firstIndex(where: {$0.id == step.id})!
    }
    
    private func getCellPositionByIndex(_ index: Int) -> CellPosition {
        if index == 0 {
            return .first
        }
        else if index == viewModel.recipe.steps.count - 1 {
            return .last
        }
        else {
            return .middle
        }
    }
    
}

struct ExtractRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeDetailView(viewModel: ExtractRecipeDetailViewModel(extractRecipeStore: ExtractRecipeStore(), recipe: ExtractRecipeStore().list[0]))
    }
}
