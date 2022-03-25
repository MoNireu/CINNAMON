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
                RecipeListView
            }
        }
        .listStyle(.plain)
        .onAppear(perform: viewModel.onAppear)
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
        }
        .navigationTitle("추출 레시피")
        .environment(\.editMode, viewModel.isEditing ? .constant(.active) : .constant(.inactive))
        .toolbar {
            ToolBarButtons
        }
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
                if viewModel.isEditing { print("Log -", #fileID, #function, #line, viewModel.selectedRecipe) }
                else { print("Log -", #fileID, #function, #line) }
            } label: {
                Image(systemName: viewModel.isEditing ? "trash" : "plus")
                    .foregroundColor(viewModel.isEditing ? .red : .blue)
            }
        }
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
    }
}
