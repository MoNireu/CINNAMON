//
//  ExtractView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListView: View {
//    @EnvironmentObject var extractRecipeListData: ExtractRecipeListData
    @ObservedObject var viewModel: ExtractRecipeListViewModel
    
    init(viewModel: ExtractRecipeListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                addExtractTypePicker()
                addRecipeList()
            }
        }
        .listStyle(.plain)
    }
    
    
    func addExtractTypePicker() -> some View {
        Picker("extractType", selection: $viewModel.selectedExtractType) {
            Text("에스프레소").tag(ExtractType.espresso)
            Text("브루잉").tag(ExtractType.brew)
        }
        .pickerStyle(.segmented)
        .padding()
        .disabled(viewModel.editingMode == .inactive ? false : true)
        .onChange(of: viewModel.editingMode) { newValue in
            if newValue == .inactive {
                viewModel.selectedRecipe = Set<UUID>()
            }
        }
    }
    
    
    func addRecipeList() -> some View {
        List(viewModel.filteredRecipeList, selection: $viewModel.selectedRecipe) { recipe in
            NavigationLink {
                ExtractRecipeDetailView(viewModel: ExtractRecipeDetailViewModel(recipe: recipe, extractRecipeListData: viewModel.getExtractRecipeListData()))
            } label: {
                ExtractRecipeListCell(title: recipe.title,
                                      description: recipe.description,
                                      time: recipe.totalExtractTime)
            }
        }
        .navigationTitle("추출 레시피")
        .environment(\.editMode, $viewModel.editingMode)
        .toolbar {
            addToolBarButtons()
        }
    }
    
    func addToolBarButtons() -> some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            // Edit Button
            Button {
                viewModel.editingMode = (viewModel.editingMode == .inactive) ? .active : .inactive
            } label: {
                Image(systemName: viewModel.editingMode == .inactive ? "checkmark.circle" : "checkmark.circle.fill")
            }
            
            // Add Button
            Button {
                if viewModel.editingMode == .inactive { print("Log -", #fileID, #function, #line, viewModel.extractRecipeListData.list[0].title) }
                else { print("Log -", #fileID, #function, #line, viewModel.selectedRecipe) }
            } label: {
                Image(systemName: viewModel.editingMode == .inactive ? "plus" : "trash")
                    .foregroundColor(viewModel.editingMode == .inactive ? .blue : .red)
            }
        }
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView(viewModel: ExtractRecipeListViewModel(extractRecipeListData: ExtractRecipeStore()))
    }
}
