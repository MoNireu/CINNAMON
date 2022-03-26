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
    //    @ObservedObject var viewModel: ExtractRecipeListViewModel
    @Binding var isShowing: Bool
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
                    isShowing = false
                }
                Spacer()
                Button("생성") {
                    // TODO: 생성 로직
                }
                .disabled(!isAllFieldValid())
            }
            .padding(.horizontal)
            
            
            TextField("제목", text: $title)
                .focused($focusedField, equals: .beanAmount)
                .font(.system(.title))
                .padding()
            
            TextField("원두용량(g)", text: $beanAmountText)
                .focused($focusedField, equals: .beanAmount)
                .font(.system(.subheadline))
                .padding()
                .keyboardType(.decimalPad)
                .onChange(of: focusedField) { field in
                    // On Edit
                    if field == .beanAmount {
                        beanAmount = nil
                        beanAmountText = ""
                    }
                    // On Submit
                    else if field == nil {
                        if beanAmountText.doesMatch(pattern: "^[0-9.]*$") {
                            beanAmount = Float(beanAmountText)
                            beanAmountText += "g"
                        }
                        else {
                            beanAmountText = ""
                            isAlertShowing = true
                        }
                    }
                }
                .alert(isPresented: $isAlertShowing) {
                    Alert(title: Text("입력 값 오류"),
                          message: Text("숫자와 소수점만 입력해주세요."),
                          dismissButton: .default(Text("확인")))
                }
            
            TextField("(선택항목)설명", text: $description)
                .focused($focusedField, equals: .beanAmount)
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
    
    func isAllFieldValid() -> Bool {
        return !title.isEmpty && beanAmount != nil
    }
}

struct CreateExtractRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExtractRecipeView(isShowing: .constant(true))
        //        CreateExtractRecipeView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
    }
}
