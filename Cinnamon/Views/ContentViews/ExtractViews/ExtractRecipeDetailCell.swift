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
    @Binding var stepInfo: RecipeStep
    var stepIndex: Int
    @Binding var selectedStepIndex: Int
    @Binding var isPickerShowing: Bool
//    @State private var title: String
//    @State private var waterAmount: Float?
//    @State private var time: String
    @State private var isWaterAmountEditing: Bool = false
    
    
    init(cellPosition: CellPosition = .middle,
         stepInfo: Binding<RecipeStep>,
         stepIndex: Int,
         selectedStepIndex: Binding<Int>,
         isPickerShowing: Binding<Bool>) {
        self.cellPosition = cellPosition
        self._stepInfo = stepInfo
        self.stepIndex = stepIndex
        self._selectedStepIndex = selectedStepIndex
        self._isPickerShowing = isPickerShowing
//        self.title = stepInfo.wrappedValue.title!
//        self.waterAmount = stepInfo.wrappedValue.waterAmount
//        self.time = stepInfo.wrappedValue.extractTime.toMinuteString()
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
                    TextField("단계별 제목", text: $stepInfo.title)
                        .padding(.leading)
                        .padding(.top)
                    HStack {
                        Spacer()
                        TextField("0ml", value: $stepInfo.waterAmount, format: .number)
                            .fixedSize()
                            .onTapGesture {
                                isWaterAmountEditing = true
                            }
                            .onSubmit {
                                isWaterAmountEditing = stepInfo.waterAmount != nil ? false : true
                            }
                        if !isWaterAmountEditing { Text("ml") }
                        Spacer()
                        Text("\(TimeConvertUtil.timeIntToString(time: stepInfo.extractTime))")
                            .onTapGesture {
                                selectedStepIndex = stepIndex
                                isPickerShowing.toggle()
                            }
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
        ExtractRecipeDetailCell(cellPosition: .first,
                                stepInfo: .constant(RecipeStep(title: "title", description: "", waterAmount: 1.0, extractTime: 10)),
                                stepIndex: 0,
                                selectedStepIndex: .constant(0),
                                isPickerShowing: .constant(false))
    }
}


