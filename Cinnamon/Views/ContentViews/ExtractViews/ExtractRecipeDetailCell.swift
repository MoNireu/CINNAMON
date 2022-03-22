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
    @EnvironmentObject var extractRecipeStore: ExtractRecipeStore
    var cellPosition: CellPosition
    @Binding var stepInfo: RecipeStep
    var stepIndex: Int
    @Binding var selectedStepIndex: Int
    @Binding var isPickerShowing: Bool
    var isParentEditing: Bool
    
    @State private var isWaterAmountEditing: Bool = false
    @State private var isDescriptionShowing: Bool
    @State private var isDescriptionPlaceHolderVisible: Bool
    @FocusState private var isDescriptionFocused: Bool
    
    let DESCRIPTION_PLACE_HOLDER = "(선택) 설명을 입력해주세요."
    
    
    init(cellPosition: CellPosition = .middle,
         stepInfo: Binding<RecipeStep>,
         stepIndex: Int,
         selectedStepIndex: Binding<Int>,
         isPickerShowing: Binding<Bool>,
         isParentEditing: Bool) {
        self.cellPosition = cellPosition
        self._stepInfo = stepInfo
        self.stepIndex = stepIndex
        self._selectedStepIndex = selectedStepIndex
        self._isPickerShowing = isPickerShowing
        self.isParentEditing = isParentEditing
        self._isDescriptionShowing = .init(initialValue: isParentEditing)
        self._isDescriptionPlaceHolderVisible = .init(initialValue: stepInfo.wrappedValue.description.isEmpty ? true : false)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 5.0)
                .padding(getEdgeByCellPosition(), 50)
                .ignoresSafeArea()

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
                    
                    if isDescriptionShowing {
                        DesCriptionView
                    }
                    
                    if !isParentEditing && !stepInfo.description.isEmpty {
                        ShowDescriptionButton
                    }
                }
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .shadow(radius: 5.0)
                }
                .padding()
            
        }
    }
    
    @ViewBuilder var ShowDescriptionButton: some View {
        HStack {
            Spacer()
            Image(systemName: "note.text")
                .tint(isDescriptionShowing ? .gray : .blue)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .onTapGesture {
            withAnimation {
                isDescriptionShowing.toggle()
            }
            print("Log -", #fileID, #function, #line)
        }
    }
    
    @ViewBuilder var DesCriptionView: some View {
        if isParentEditing {
            ZStack {
                TextEditor(text: $stepInfo.description)
                    .disableAutocorrection(true)
                    .submitLabel(.done)
                    .padding()
                    .focused($isDescriptionFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Button("완료") {
                                isDescriptionFocused = false
                            }
                        }
                    }
                    .onChange(of: isDescriptionFocused) { focused in
                        if focused {
                            isDescriptionPlaceHolderVisible = false
                        }
                        else {
                            isDescriptionPlaceHolderVisible = stepInfo.description.isEmpty ? true : false
                        }
                    }
                    .onChange(of: stepInfo.description) { text in
                        if text.last == "\n" {
                            stepInfo.description.popLast()
                            isDescriptionFocused = false
                        }
                    }
                    
                
                Text(DESCRIPTION_PLACE_HOLDER)
                    .foregroundColor(.gray)
                    .isHidden(!isDescriptionPlaceHolderVisible)
                    .allowsHitTesting(false)
            }
        }
        else {
            Text(stepInfo.description)
        }
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
                                stepInfo: .constant(RecipeStep(title: "title", description: "Description", waterAmount: 1.0, extractTime: 10)),
                                stepIndex: 0,
                                selectedStepIndex: .constant(0),
                                isPickerShowing: .constant(false),
                                isParentEditing: true)
    }
}


