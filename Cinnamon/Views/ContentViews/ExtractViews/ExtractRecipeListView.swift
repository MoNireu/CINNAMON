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
                Picker("extractType", selection: $viewModel.selectedExtractType) {
                    Text("에스프레소").tag(ExtractType.espresso)
                    Text("브루잉").tag(ExtractType.brew)
                }
                .pickerStyle(.segmented)
                .padding()
                
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
        }
        .listStyle(.plain)
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView(viewModel: ExtractRecipeListViewModel())
    }
}
