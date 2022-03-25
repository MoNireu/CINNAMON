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

enum FocusedField {
    case waterAmount, description
}


struct ExtractRecipeDetailCell: View {
    @Binding var step: RecipeStep
    @ObservedObject var viewModel: ExtractRecipeDetailViewModel
    
    @FocusState var isDescriptionFocused: Bool
    @FocusState var focusedField: FocusedField?
    @State var isDescriptionShowing: Bool = true
    @State var isDescriptionPlaceHolderVisible: Bool = false
    
    init(step: Binding<RecipeStep>, viewModel: ExtractRecipeDetailViewModel) {
        self._step = step
        self._viewModel = .init(initialValue: viewModel)
    }

    let DESCRIPTION_PLACE_HOLDER = "(선택) 설명을 입력해주세요."

    var body: some View {
        ZStack {
            BackgroundVerticalLine
            
            VStack {
                StepTitleView
                
                HStack {
                    Spacer()
                    WaterAmountView
                    Spacer()
                    ExtractTimeView
                    Spacer()
                }
                .multilineTextAlignment(.center)
                .padding()

                if isDescriptionShowing {
                    DescriptionView
                }

                if !viewModel.isEditing && !step.description.isEmpty {
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
            isDescriptionShowing = viewModel.isEditing
            isDescriptionPlaceHolderVisible = isDescriptionEmpty()
        }
        .onReceive(viewModel.$stopFocus) { _ in
            focusedField = nil
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
            .padding(.leading)
            .padding(.top)
    }
    
    @ViewBuilder var WaterAmountView: some View {
        TextField("물용량", value: $step.waterAmount, format: .number)
            .focused($focusedField, equals: .waterAmount)
            .multilineTextAlignment(.trailing)
            .fixedSize()
            .keyboardType(.decimalPad)
        Text("ml")
            .fixedSize()
            .foregroundColor(step.waterAmount == nil ? .gray : .primary)
            .onChange(of: step.waterAmount) { newValue in
                print("Log -", #fileID, #function, #line, newValue)
            }
    }
    
    @ViewBuilder var ExtractTimeView: some View {
        Text("\(TimeConvertUtil.timeIntToString(time: step.extractTime))")
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
        if viewModel.isEditing {
            ZStack {
                TextEditor(text: $step.description)
                    .disableAutocorrection(true)
                    .submitLabel(.done)
                    .padding()
                    .focused($focusedField, equals: .description)
                    .onChange(of: focusedField) { field in
                        if field == .description {
                            isDescriptionPlaceHolderVisible = false
                        }
                        else {
                            isDescriptionPlaceHolderVisible = isDescriptionEmpty()
                        }
                    }
                    .onChange(of: step.description) { text in
                        if text.last == "\n" {
                            step.description.removeLast()
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
        let recipe = ExtractRecipe(title: "브루잉 레시피 2",
                                   description: "1분 30초 브루잉 레시피",
                                   extractType: .brew,
                                   totalExtractTime: 90,
                                   beanAmount: 20.0,
                                   steps: [
                                     RecipeStep(title: "뜸 들이기", description: "", waterAmount: 40, extractTime: 60),
                                     RecipeStep(title: "1차 푸어링", description: "", waterAmount: 80, extractTime: 60),
                                     RecipeStep(title: "2차 푸어링", description: "", waterAmount: 40, extractTime: 40)
                                   ])
        
        ExtractRecipeDetailCell(step: .constant(recipe.steps[0]),
                                viewModel: ExtractRecipeDetailViewModel(recipe: recipe))
    }
}


