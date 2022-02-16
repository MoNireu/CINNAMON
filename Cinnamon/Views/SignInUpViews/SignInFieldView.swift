//
//  SignInFieldView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/15.
//

import SwiftUI

struct SignInFieldView: View {
    @Binding var id: String
    @Binding var password: String
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            VStack {
                Group {
                    TextField("아이디", text: $id)
                    TextField("비밀번호", text: $password)
                }
                .padding()
                .frame(height: 50.0)
                .overlay {
                    RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.gray, lineWidth: 2)
                }
            }
            .padding(.top, 20.0)
            .padding(.leading, 30.0)
            .padding(.trailing, 30.0)
            .background(Color.clear)
            
            HStack {
                Spacer()
                Button {
                    print("Log -", #fileID, #function, #line, "로그인 취소")
                    isShown.toggle()
                } label: {
                    Text("취소")
                }
                Spacer()
                Button {
                    print("Log -", #fileID, #function, #line, "로그인 취소")
                } label: {
                    Text("로그인")
                }
                Spacer()
            }
            .padding()
        }
        .frame(maxHeight: 300.0)
        .background(Color.white)
        .cornerRadius(10.0)
        .padding(.leading, 18.0)
        .padding(.trailing, 18.0)
    }
}

struct SignInFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SignInFieldView(id: Binding.constant(""), password: Binding.constant(""), isShown: Binding.constant(false))
    }
}
