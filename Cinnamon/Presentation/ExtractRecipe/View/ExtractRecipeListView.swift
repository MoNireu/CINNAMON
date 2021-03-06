//
//  ExtractView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListView: View {
    @StateObject var viewModel: ExtractRecipeListViewModel
    
    init(viewModel: ExtractRecipeListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ExtractTypePicker
                ZStack {
                    RecipeListView
                    if viewModel.isRecipeEmpty {
                        Text("레시피를 추가해주세요")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                }
                NewRecipeEditView
            }
            .toolbar {
                ToolBarButtons
            }
        }
        .listStyle(.plain)
        .onAppear(perform: viewModel.onAppear)
        .sheet(isPresented: $viewModel.isCreateRecipeShowing) {
            ExtractRecipeBaseInfoView(extractType: viewModel.selectedExtractType)
        }
    }
}

extension ExtractRecipeListView {
    
    @ViewBuilder var ExtractTypePicker: some View {
        Picker("extractType", selection: $viewModel.selectedExtractType) {
            Text("에스프레소").tag(ExtractType.espresso)
            Text("브루잉").tag(ExtractType.brew)
        }
        .pickerStyle(.segmented)
        .padding()
        .disabled(viewModel.isEditing ? true : false)
    }
    
    
    @ViewBuilder var RecipeListView: some View {
        List(selection: $viewModel.selectedRecipe) {
            ForEach(viewModel.recipes) { recipe in
                NavigationLink {
                    ExtractRecipeDetailView(recipe: recipe)
                } label: {
                    ExtractRecipeListCell(title: recipe.title,
                                          description: recipe.description,
                                          time: recipe.totalExtractTime)
                }
            }
            .onDelete(perform: viewModel.deleteRecipe)
        }
        .navigationTitle("추출 레시피")
        .environment(\.editMode, viewModel.isEditing ? .constant(.active) : .constant(.inactive))
    }
    
    @ToolbarContentBuilder var ToolBarButtons: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            // Edit Button
            Button {
                viewModel.isEditing.toggle()
            } label: {
                Image(systemName: viewModel.isEditing ? "checkmark.circle.fill" : "checkmark.circle" )
            }
            
            // Add Button
            Button {
                if viewModel.isEditing {
                    //TODO: 선택된 항목 삭제하기.
                    print("Log -", #fileID, #function, #line)
                }
                else {
                    viewModel.showCreateRecipeView()
                }
            } label: {
                Image(systemName: viewModel.isEditing ? "trash" : "plus")
                    .foregroundColor(viewModel.isEditing ? .red : .blue)
            }
        }
    }
    
    @ViewBuilder var NewRecipeEditView: some View {
        if viewModel.createdRecipe != nil {
            let recipe = viewModel.createdRecipe!
            NavigationLink(isActive: .constant(true)) {
                ExtractRecipeDetailView(recipe: recipe)
                    .onDisappear {
                        viewModel.createdRecipe = nil
                    }
            } label: {
                ExtractRecipeListCell(title: recipe.title,
                                      description: recipe.description,
                                      time: recipe.totalExtractTime)
            }
            .hidden()
        }
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
    }
}
