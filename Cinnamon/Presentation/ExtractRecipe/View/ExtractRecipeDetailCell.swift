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

enum ExtractRecipeDetailCellFocusedField {
    case title
    case waterAmount
    case description
}

struct ExtractRecipeDetailCell: View {
    @Binding var step: RecipeStep
    @StateObject var viewModel: ExtractRecipeDetailViewModel
    
    @FocusState var focusedField: ExtractRecipeDetailCellFocusedField?
    @State var isDescriptionShowing: Bool = true
    @State var isDescriptionPlaceHolderVisible: Bool = false
    
    init(step: Binding<RecipeStep>, viewModel: ExtractRecipeDetailViewModel) {
        self._step = step
        self._viewModel = .init(wrappedValue: viewModel)
    }

    let DESCRIPTION_PLACE_HOLDER = "(선택) 설명을 입력해주세요."

    var body: some View {
        ZStack {
            BackgroundVerticalLine
            
            VStack {
                Group {
                    StepTitleView
                    
                    HStack {
                        Spacer()
                        WaterAmountView
                        Spacer()
                        ExtractTimeView
                        Spacer()
                    }
                    .padding()
                    .disabled(!viewModel.isRecipeEditing)
                    
                    if isDescriptionShowing {
                        DescriptionView
                    }
                }
                .disabled(!viewModel.isRecipeEditing)

                if !viewModel.isRecipeEditing && !step.description.isEmpty {
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
        .onAppear {
            isDescriptionShowing = viewModel.isRecipeEditing
            isDescriptionPlaceHolderVisible = isDescriptionEmpty()
        }
        // keyboard toolbar "확인" 버튼이 눌리면 편집중인 Step의 모든 Focus 해제.
        .onReceive(viewModel.$stopFocus) { _ in
            focusedField = nil
        }
        // 편집중인 step이 있다면 상단 Recipe편집 완료버튼을 비활성화.
        .onChange(of: focusedField) { field in
            if field == .description {
                isDescriptionPlaceHolderVisible = false
            }
            else {
                isDescriptionPlaceHolderVisible = isDescriptionEmpty()
            }
        }
    }
}

extension ExtractRecipeDetailCell {
    @ViewBuilder var BackgroundVerticalLine: some View {
        Rectangle()
            .frame(width: 5.0)
            .padding(getEdgeByCellIndex(), 50)
            .ignoresSafeArea()
    }
    
    @ViewBuilder var StepTitleView: some View {
        TextField("단계별 제목", text: $step.title)
            .disableAutocorrection(true)
            .padding(.leading)
            .padding(.top)
            .focused($focusedField, equals: .title)
    }
    
    @ViewBuilder var WaterAmountView: some View {
        TextField("물용량", value: $step.waterAmount, format: .number)
            .focused($focusedField, equals: .waterAmount)
            .disableAutocorrection(true)
            .multilineTextAlignment(.trailing)
            .fixedSize()
            .keyboardType(.decimalPad)
        Text("ml")
            .fixedSize()
            .foregroundColor(step.waterAmount == nil ? .gray : .primary)
            .onTapGesture {
                focusedField = .waterAmount
            }
    }
    
    @ViewBuilder var ExtractTimeView: some View {
        Text("\(TimeConvertUtil.shared.timeIntToString(time: step.extractTime))")
            .foregroundColor(step.extractTime == 0 ? .gray : .primary)
            .onTapGesture {
                viewModel.showTimePicker(step: step)
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

    @ViewBuilder var DescriptionView: some View {
        if viewModel.isRecipeEditing {
            ZStack {
                TextEditor(text: $step.description)
                    .disableAutocorrection(true)
                    .submitLabel(.done)
                    .padding()
                    .focused($focusedField, equals: .description)


                Text(DESCRIPTION_PLACE_HOLDER)
                    .foregroundColor(.gray)
                    .isHidden(!isDescriptionPlaceHolderVisible)
                    .allowsHitTesting(false)
            }
        }
        else {
            Text(step.description)
        }
    }
    
    func isDescriptionEmpty() -> Bool {
        return self.step.description.isEmpty ? true : false
    }
    
    func getEdgeByCellIndex() -> Edge.Set {
        switch viewModel.getStepIndex(step: step) {
        case 0:
            return .top
        case viewModel.recipe.steps.count - 1:
            return .bottom
        default:
            return .horizontal
        }
    }
}

struct ExtractRecipeDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        let recipe = ExtractRecipeDummyData.extractRecipeList[3]
        
        ExtractRecipeDetailCell(step: .constant(recipe.steps[0]),
                                viewModel: ExtractRecipeDetailViewModel(recipe: recipe))
    }
}


