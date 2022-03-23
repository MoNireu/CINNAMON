////
////  ExtractRecipeEditCell.swift
////  Cinnamon
////
////  Created by MoNireu on 2022/03/15.
////
//
//import SwiftUI
//
//enum CellPosition{
//    case first
//    case middle
//    case last
//}
//
//
//struct ExtractRecipeDetailCell: View {
//    @EnvironmentObject var extractRecipeStore: ExtractRecipe
//    @ObservedObject var viewModel: ExtractRecipeDetailCellViewModel
//    @FocusState var isDescriptionFocused: Bool
//    //    var cellPosition: CellPosition
//    //    @Binding var stepInfo: RecipeStep
//    //    var stepIndex: Int
//    //    @Binding var selectedStepIndex: Int
//    //    @Binding var isPickerShowing: Bool
//    //    var isParentEditing: Bool
//    //
//    //    @State private var isWaterAmountEditing: Bool = false
//    //    @State private var isDescriptionShowing: Bool
//    //    @State private var isDescriptionPlaceHolderVisible: Bool
//    //    @FocusState private var isDescriptionFocused: Bool
//    //
//    //    let DESCRIPTION_PLACE_HOLDER = "(선택) 설명을 입력해주세요."
//    //
//    //
//    //    init(cellPosition: CellPosition = .middle,
//    //         stepInfo: Binding<RecipeStep>,
//    //         stepIndex: Int,
//    //         selectedStepIndex: Binding<Int>,
//    //         isPickerShowing: Binding<Bool>,
//    //         isParentEditing: Bool) {
//    //        self.cellPosition = cellPosition
//    //        self._stepInfo = stepInfo
//    //        self.stepIndex = stepIndex
//    //        self._selectedStepIndex = selectedStepIndex
//    //        self._isPickerShowing = isPickerShowing
//    //        self.isParentEditing = isParentEditing
//    //        self._isDescriptionShowing = .init(initialValue: isParentEditing)
//    //        self._isDescriptionPlaceHolderVisible = .init(initialValue: stepInfo.wrappedValue.description.isEmpty ? true : false)
//    //    }
//
//    let DESCRIPTION_PLACE_HOLDER = "(선택) 설명을 입력해주세요."
//
//    var body: some View {
//        ZStack {
//            Rectangle()
//                .frame(width: 5.0)
//                .padding(viewModel.getEdgeByCellIndex(), 50)
//                .ignoresSafeArea()
//
//            VStack {
//                TextField("단계별 제목", text: $viewModel.stepInfo.title)
//                    .padding(.leading)
//                    .padding(.top)
//                HStack {
//                    Spacer()
//                    TextField("0ml", value: $viewModel.stepInfo.waterAmount, format: .number)
//                        .fixedSize()
//                        .onTapGesture {
//                            viewModel.isWaterAmountEditing = true
//                        }
//                        .onSubmit {
//                            viewModel.isWaterAmountEditing = viewModel.stepInfo.waterAmount != nil ? false : true
//                        }
//                    if !viewModel.isWaterAmountEditing { Text("ml") }
//                    Spacer()
//                    Text("\(TimeConvertUtil.timeIntToString(time: viewModel.stepInfo.extractTime))")
//                        .onTapGesture {
//                            viewModel.selectedStepIndex = viewModel.stepIndex
//                            viewModel.isPickerShowing.toggle()
//                        }
//                    Spacer()
//                }
//                .multilineTextAlignment(.center)
//                .padding()
//
//                if viewModel.isDescriptionShowing {
//                    DesCriptionView
//                }
//
//                if !viewModel.isParentEditing && !viewModel.stepInfo.description.isEmpty {
//                    ShowDescriptionButton
//                }
//            }
//            .background {
//                RoundedRectangle(cornerRadius: 10)
//                    .foregroundColor(.white)
//                    .shadow(radius: 5.0)
//            }
//            .padding()
//
//        }
//    }
//
//    @ViewBuilder var ShowDescriptionButton: some View {
//        HStack {
//            Spacer()
//            Image(systemName: "note.text")
//                .tint(viewModel.isDescriptionShowing ? .gray : .blue)
//                .padding(.horizontal)
//                .padding(.bottom)
//        }
//        .onTapGesture {
//            withAnimation {
//                viewModel.isDescriptionShowing.toggle()
//            }
//            print("Log -", #fileID, #function, #line)
//        }
//    }
//
//    @ViewBuilder var DesCriptionView: some View {
//        if viewModel.isParentEditing {
//            ZStack {
//
//                TextEditor(text: $viewModel.stepInfo.description)
//                    .disableAutocorrection(true)
//                    .submitLabel(.done)
//                    .padding()
//                    .focused($isDescriptionFocused)
//                    .toolbar {
//                        ToolbarItemGroup(placement: .keyboard) {
//                            Button("완료") {
//                                isDescriptionFocused = false
//                            }
//                        }
//                    }
//                    .onChange(of: isDescriptionFocused) { focused in
//                        if focused {
//                            viewModel.isDescriptionPlaceHolderVisible = false
//                        }
//                        else {
//                            viewModel.recipe.steps[viewModel.stepIndex] = viewModel.stepInfo
//                            viewModel.isDescriptionPlaceHolderVisible = viewModel.stepInfo.description.isEmpty ? true : false
//                        }
//                    }
//                    .onChange(of: viewModel.stepInfo.description) { text in
//                        if text.last == "\n" {
//                            viewModel.stepInfo.description.popLast()
//                            isDescriptionFocused = false
//                        }
//                    }
//
//
//                Text(DESCRIPTION_PLACE_HOLDER)
//                    .foregroundColor(.gray)
//                    .isHidden(!viewModel.isDescriptionPlaceHolderVisible)
//                    .allowsHitTesting(false)
//            }
//        }
//        else {
//            Text(viewModel.stepInfo.description)
//        }
//    }
//}
//
//struct ExtractRecipeDetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        let store = ExtractRecipeStore()
//        let recipe = store.list[0]
//
//        ExtractRecipeDetailCell(
//            viewModel: ExtractRecipeDetailCellViewModel(
//                recipe: recipe,
//                stepInfo: recipe.steps[0],
//                stepIndex: 0,
//                selectedStepIndex: 0,
//                isPickerShowing: false,
//                isParentEditing: false)
//        )
//    }
//}
//
//
