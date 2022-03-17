//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeDetailView: View {
    @ObservedObject var viewModel: ExtractRecipeDetailViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("원두 용량 : ")
                    TextField("0g", value: $viewModel.beanAmount, format: .number)
                }
                .font(.system(.title2))
                .padding()
                List {
                    ForEach(viewModel.editedRecipeSteps.indices, id: \.self) { index in
                        ExtractRecipeDetailCell(cellPosition: getCellPositionByIndex(index),
                                                stepInfo: $viewModel.editedRecipeSteps[index])
                    }
                    AddNewStepButton()
                }
            }
            .navigationTitle("레시피 작성")
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
                        print("Log -", #fileID, #function, #line, "완료 버튼")
                    } label: {
                        Text("완료")
                    }
                }
            }
        }
    }
    
    func getCellPositionByIndex(_ index: Int) -> CellPosition {
        if index == 0 {
            return .first
        }
        else if index == viewModel.editedRecipeSteps.count - 1 {
            return .last
        }
        else {
            return .middle
        }
    }
    
}

struct ExtractRecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeDetailView(viewModel: ExtractRecipeDetailViewModel(recipe: ExtractRecipe(title: "ExtractTitle",
                                                                                          description: "Description",
                                                                                          extractType: .espresso,
                                                                                          totalExtractTime: 60,
                                                                                          beanAmount: 1.0,
                                                                                              recipeDetail: []),
                                                                        extractRecipeListData: ExtractRecipeStore()))
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
