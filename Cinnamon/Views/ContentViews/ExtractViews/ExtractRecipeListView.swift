//
//  ExtractView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListView: View {
    @State private var extractType: ExtractType = .espresso
    @State private var isModifying: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("extractType", selection: $extractType) {
                    Text("에스프레소").tag(ExtractType.espresso)
                    Text("브루잉").tag(ExtractType.brew)
                }
                .pickerStyle(.segmented)
                .padding()
                
                List {
                    switch extractType {
                    case .espresso:
                        NavigationLink {
                            EmptyView()
                        } label: {
                            ExtractRecipeListCell(title: "초간단 에스프레소 레시피", description: "1분 30초만에 따라하는 초간단 레시피", time: 200)
                        }
                    case .brew:
                        NavigationLink {
                            EmptyView()
                        } label: {
                            ExtractRecipeListCell(title: "초간단 브루잉 레시피", description: "1분 30초만에 따라하는 초간단 레시피", time: 90)
                        }
                        NavigationLink {
                            EmptyView()
                        } label: {
                            ExtractRecipeListCell(title: "초간단 브루잉 레시피", description: "1분 30초만에 따라하는 초간단 레시피", time: 100)
                        }
                    }
                }
                .navigationTitle("추출 레시피")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        if isModifying {
                            Button {
                                print("")
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                        Button {
                            isModifying.toggle()
                        } label: {
                            Image(systemName: isModifying ? "checkmark.circle.fill" : "checkmark.circle")
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
        ExtractRecipeListView()
    }
}
