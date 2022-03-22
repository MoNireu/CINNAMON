//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExtractRecipeDetailViewModel
    @State private var isPickerShowing: Bool = false
    @State private var selectedStepIndex: Int = 0
    @State private var isEditing: Bool = false
    
    
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
                        isEditing.toggle()
                        print("Log -", #fileID, #function, #line, "편집 버튼")
                    } label: {
                        Text("편집")
                    }
                    Button {
                        viewModel.completeEditing()
                        dismiss()
                        print("Log -", #fileID, #function, #line, "완료 버튼")
                    } label: {
                        Text("완료")
                    }
                }
            }
        }
        .popup(isPresented: $isPickerShowing) {
            BottomPopupView(isPresented: $isPickerShowing) {
                MinuteSecondPicker(timeInt: $viewModel.recipe.recipeSteps[selectedStepIndex].extractTime, isShowing: $isPickerShowing)
            }
        }
    }
    
    private func getReusableViewByEditMode() -> some View {
        if isEditing {
            return AnyView(getListView())
        }
        else {
            return AnyView(getScrollView())
        }
    }
    
    
    private func getListView() -> some View {
        List {
            getEachCell()
            AddNewStepButton()
        }
    }
    
    private func getScrollView() -> some View {
        ScrollView {
            getEachCell()
        }
    }
    
    private func getEachCell() -> some View {
        ForEach($viewModel.recipe.recipeSteps) { $step in
            let index = getStepIndex(step)
            ExtractRecipeDetailCell(cellPosition: getCellPositionByIndex(index),
                                    stepInfo: $step,
                                    stepIndex: index,
                                    selectedStepIndex: $selectedStepIndex,
                                    isPickerShowing: $isPickerShowing)
            .padding(.vertical, -4)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 3.5, leading: 0, bottom: 3.5, trailing: 0))
        }
    }
    
    private func getStepIndex(_ step: RecipeStep) -> Int {
        viewModel.recipe.recipeSteps.firstIndex(where: {$0.id == step.id})!
    }
    
    private func getCellPositionByIndex(_ index: Int) -> CellPosition {
        if index == 0 {
            return .first
        }
        else if index == viewModel.recipe.recipeSteps.count - 1 {
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

struct AddNewStepButton: View {
    var body: some View {
        Button {
            print("레시피 단계 추가")
        } label: {
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
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}
