//
//  ExtractView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListView: View {
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
    }
    
    func addRecipeList() -> some View {
        List(viewModel.recipeList) { recipe in
            if recipe.extractType == viewModel.selectedExtractType {
                NavigationLink {
                    EmptyView()
                } label: {
                    ExtractRecipeListCell(title: recipe.title,
                                          description: recipe.description,
                                          time: recipe.totalExtractTime)
                }
            }
        }
        .navigationTitle("추출 레시피")
        .toolbar {
            addToolBarButtons()
        }
    }
    
    func addToolBarButtons() -> some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            if viewModel.isModifying {
                Button {
                    print("")
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            Button {
                viewModel.isModifying.toggle()
            } label: {
                Image(systemName: viewModel.isModifying ? "checkmark.circle.fill" : "checkmark.circle")
            }
            Button {
                print("")
            } label: {
                Image(systemName: "plus")
            }
        }
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView(viewModel: ExtractRecipeListViewModel())
    }
}
