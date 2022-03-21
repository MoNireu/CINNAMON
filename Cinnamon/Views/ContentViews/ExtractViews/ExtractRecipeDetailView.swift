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
    
    var body: some View {
        VStack {
            HStack {
                Text("원두 용량 : ")
                TextField("0g", value: $viewModel.recipe.beanAmount, format: .number)
            }
            .font(.system(.title2))
            .padding()
            List {
                ForEach($viewModel.recipe.recipeSteps) { $step in
                    let index = getStepIndex(step)
                    ExtractRecipeDetailCell(cellPosition: getCellPositionByIndex(index),
                                            stepInfo: $step,
                                            stepIndex: index,
                                            selectedStepIndex: $selectedStepIndex,
                                            isPickerShowing: $isPickerShowing)
                }
                AddNewStepButton()
            }
            .navigationTitle(viewModel.recipe.title)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                //                ToolbarItem(placement: .navigationBarLeading) {
                //                    Button {
                //                        print("Log -", #fileID, #function, #line, "취소 버튼")
                //                    } label: {
                //                        Text("취소")
                //                    }
                //                }
                ToolbarItem(placement: .navigationBarTrailing) {
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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 5.0)
                
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(.title))
                        .padding()
                    Spacer()
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}
