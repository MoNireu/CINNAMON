//
//  ExtractView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListView: View {
    
    var body: some View {
        NavigationView {
            List {
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
                NavigationLink {
                    EmptyView()
                } label: {
                    ExtractRecipeListCell(title: "초간단 브루잉 레시피", description: "1분 30초만에 따라하는 초간단 레시피", time: 200)
                }
            }
            .navigationTitle("추출 레시피")
        }
        .listStyle(.plain)
    }
}

struct ExtractRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListView()
    }
}
