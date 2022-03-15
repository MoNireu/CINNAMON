//
//  ExtractRecipeView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/15.
//

import SwiftUI

struct ExtractRecipeEditView: View {
    @State var beanAmount: Float?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("원두 용량 : ")
                    TextField("0g", value: $beanAmount, format: .number)
                }
                .font(.system(.title2))
                .padding()
                List {
                    ExtractRecipeEditCell(cellPosition: .first)
                    ExtractRecipeEditCell()
                    ExtractRecipeEditCell()
                    ExtractRecipeEditCell()
                    ExtractRecipeEditCell()
                    ExtractRecipeEditCell()
                    ExtractRecipeEditCell(cellPosition: .last)
                    AddNewStepButton()
                }
            }
            .navigationTitle("레시피 작성")
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        print("Log -", #fileID, #function, #line, "취소 버튼")
                    } label: {
                        Text("취소")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("Log -", #fileID, #function, #line, "완료 버튼")
                    } label: {
                        Text("완료")
                    }
                }
            }
        }
    }
}

struct ExtractRecipeEditView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeEditView()
    }
}

struct AddNewStepButton: View {
    var body: some View {
        Button {
            print("레시피 단계 추가")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .shadow(radius: 5.0)
                
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.system(.title))
                        .padding()
                    Spacer()
                }
            }
        }
        .listRowSeparator(.hidden)
    }
}
