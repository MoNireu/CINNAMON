//
//  CreateExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/26.
//
import SwiftUI
import Foundation

enum ExtractRecipeBaseInfoFocusedField {
    case title
    case description
    case beanAmount
}

enum ExtractRecipeBaseInfoAlert {
    case createAlert
    case beanAmountAlert
}

struct ExtractRecipeBaseInfoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ExtractRecipeBaseInfoViewModel
    @FocusState var focusedField: ExtractRecipeBaseInfoFocusedField?
    
    
    /// 레시피 생성 모드 Initializer
    /// - Parameter extractType: 추출 타입.
    init(extractType: ExtractType) {
        self._viewModel = .init(initialValue: ExtractRecipeBaseInfoViewModel(extractType: extractType))
    }
    
    
    ///  레시피 기본정보 읽기 / 수정 모드 Initializer
    /// - Parameters:
    ///   - recipe: 수정 및 읽을 레시피
    ///   - viewMode: 수정 및 읽기 모드 선택
    init(recipe: ExtractRecipe, viewMode: ExtractRecipeBaseInfoViewMode) {
        self._viewModel = .init(initialValue: ExtractRecipeBaseInfoViewModel(recipe: recipe, viewMode: viewMode))
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("제목", text: $viewModel.title)
                    .focused($focusedField, equals: .title)
                    .disableAutocorrection(true)
                    .font(.system(.title))
                    .padding()
                    .disabled(viewModel.isViewReadMode())
                
                TextField("부제목 (선택)", text: $viewModel.description)
                    .focused($focusedField, equals: .description)
                    .disableAutocorrection(true)
                    .font(.system(.subheadline))
                    .padding()
                    .disabled(viewModel.isViewReadMode())
                
                TextField("원두용량(g)", text: $viewModel.beanAmountText)
                    .focused($focusedField, equals: .beanAmount)
                    .disableAutocorrection(true)
                    .font(.system(.subheadline))
                    .padding()
                    .keyboardType(.decimalPad)
                    .onTapGesture {
                        viewModel.beanAmount = nil
                        viewModel.beanAmountText = ""
                    }
                    .onChange(of: focusedField) { field in
                        viewModel.formatBeanAmountText(field: field)
                        viewModel.checkIfAllFieldValid()
                    }
                    .alert(isPresented: $viewModel.isAlertShowing) {
                        Alert(title: Text("입력 값 오류"),
                              message: Text("숫자와 소수점만 입력해주세요."),
                              dismissButton: .default(Text("확인")))
                    }
                    .disabled(viewModel.isViewReadMode())
                
                Spacer()
            }
            .navigationTitle(Text(viewModel.getNavigationTitle()))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("완료") {
                        focusedField = nil
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        dismiss()
                    }
                    .isHidden(viewModel.isViewReadMode())
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        switch viewModel.viewMode{
                        case .create:
                            viewModel.createRecipe()
                        case .update:
                            viewModel.updateRecipe()
                        case .read:
                            dismiss()
                        }
                    }
                    .disabled(!viewModel.isAllFieldValid)
                }
            }
        }
        .onChange(of: viewModel.dismiss) { dismiss in
            if dismiss { self.dismiss() }
        }
    }
}

extension ExtractRecipeBaseInfoView {
}

struct ExtractRecipeBaseInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeBaseInfoView(extractType: .espresso)
    }
}
