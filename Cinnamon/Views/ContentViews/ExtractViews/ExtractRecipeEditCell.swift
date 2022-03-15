//
//  ExtractRecipeEditCell.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

enum CellPosition{
    case first
    case middle
    case last
}


struct ExtractRecipeEditCell: View {
    var cellPosition: CellPosition = .middle
    @State var title: String = ""
    @State var waterAmount: Float?
    @State var time: String = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 5.0)
                .padding(getEdgeByCellPosition())
            Group {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 5.0)
                VStack {
                    TextField("단계별 제목", text: $title)
                        .padding(.leading)
                        .padding(.top)
                    HStack {
                        TextField("0ml", value: $waterAmount, format: .number)
                        TextField("0초", text: $time)
                    }
                    .multilineTextAlignment(.center)
                    .padding()
                }
            }
            .padding()
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
    
    private func getEdgeByCellPosition() -> Edge.Set {
        switch cellPosition {
        case .first:
            return .top
        case .middle:
            return .horizontal
        case .last:
            return .bottom
        }
    }
}

struct ExtractRecipeEditCell_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeEditCell()
    }
}
