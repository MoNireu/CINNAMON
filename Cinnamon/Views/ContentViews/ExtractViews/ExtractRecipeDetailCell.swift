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


struct ExtractRecipeDetailCell: View {
    var cellPosition: CellPosition
    var stepInfo: RecipeDetail?
    @State var title: String
    @State var waterAmount: Float?
    @State var time: String
    @State var isWaterAmountEditing: Bool = false
    
    init(cellPosition: CellPosition = .middle, stepInfo: RecipeDetail? = nil) {
        self.cellPosition = cellPosition
        
        if let stepInfo = stepInfo {
            self.stepInfo = stepInfo
            self.title = stepInfo.title ?? ""
            self.waterAmount = stepInfo.waterAmount
            self.time = stepInfo.extractTime.toMinuteString()
            print("Log -", #fileID, #function, #line, "Yes")
        }
        else {
            self.stepInfo = nil
            self.title = ""
            self.waterAmount = nil
            self.time = ""
            print("Log -", #fileID, #function, #line, "No")
        }
    }
    
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
                        Spacer()
                        TextField("0ml", value: $waterAmount, format: .number)
                            .fixedSize()
                            .onTapGesture {
                                isWaterAmountEditing = true
                            }
                            .onSubmit {
                                isWaterAmountEditing = waterAmount != nil ? false : true
                            }
                        if !isWaterAmountEditing { Text("ml") }
                        Spacer()
                        TextField("0초", text: $time)
                            .fixedSize()
                        Spacer()
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

struct ExtractRecipeDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeDetailCell()
    }
}