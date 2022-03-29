//
//  CreateExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/26.
//
import SwiftUI
import Foundation

enum CreateRecipeFocusedField {
    case title
    case description
    case beanAmount
}

enum CreateRecipeAlert {
    case createAlert
    case beanAmountAlert
}

struct CreateExtractRecipeView: View {
    @ObservedObject var viewModel: ExtractRecipeListViewModel
    @State var title: String = ""
    @State var description: String = ""
    @State var beanAmount: Float?
    @State var beanAmountText: String = ""
    @State var isAlertShowing: Bool = false
    @FocusState var focusedField: CreateRecipeFocusedField?

    var body: some View {
        VStack {
            HStack {
                Button("취소") {
                    viewModel.isCreateRecipeShowing = false
                }
                Spacer()
                Button("생성") {
                    viewModel.createRecipe(title: title,
                                           description: description,
                                           beanAmount: beanAmount!)
                }
                .disabled(!isAllFieldValid())
            }
            .padding(.horizontal)
            
            
            TextField("제목", text: $title)
                .focused($focusedField, equals: .title)
                .font(.system(.title))
                .padding()
            
            TextField("원두용량(g)", text: $beanAmountText)
                .focused($focusedField, equals: .beanAmount)
                .font(.system(.subheadline))
                .padding()
                .keyboardType(.decimalPad)
                .onTapGesture {
                    beanAmount = nil
                    beanAmountText = ""
                }
                .onChange(of: focusedField) { field in
                    formatBeanAmountText(field: field)
                }
                .alert(isPresented: $isAlertShowing) {
                    Alert(title: Text("입력 값 오류"),
                          message: Text("숫자와 소수점만 입력해주세요."),
                          dismissButton: .default(Text("확인")))
                }
            
            TextField("(선택항목)설명", text: $description)
                .focused($focusedField, equals: .description)
                .font(.system(.subheadline))
                .padding()
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button("완료") {
                        focusedField = nil
                    }
                }
            }
        }
    }
}

extension CreateExtractRecipeView {
    func isAllFieldValid() -> Bool {
        return !title.isEmpty && beanAmount != nil
    }
    
    func formatBeanAmountText(field: CreateRecipeFocusedField?) {
        guard field != .beanAmount else {return}
        guard !beanAmountText.isEmpty else {return}
        if beanAmountText.doesMatch(pattern: "^[0-9.]*$") {
            beanAmount = Float(beanAmountText)
            beanAmountText += "g"
        }
        else if beanAmountText.last! == "g" {
            var gramRemovedBeanAmountText = beanAmountText
            gramRemovedBeanAmountText.removeLast()
            beanAmount = Float(gramRemovedBeanAmountText)
        }
        else {
            beanAmountText = ""
            isAlertShowing = true
        }
    }
}

struct CreateExtractRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExtractRecipeView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
    }
}
