//
//  AccountSetupView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/07.
//

import SwiftUI

struct AccountSetupView: View {
    @State private var myId: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            HStack {
                ProgressView()
                    .padding()
                    .hidden()
                
                TextField("아이디 입력", text: $myId)
                    .multilineTextAlignment(.center)
                .font(.system(.title))
                
                ProgressView()
                    .padding()
                    .hidden()
            }
            
            Text("이미 존재하는 아이디 입니다.")
                .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                Image(systemName: "square")
                    .font(.system(.title2))
                
                Text("개인정보 이용 동의")
            }
            
            Spacer()
            
            Button {
                print()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .frame(height: 50.0)
                        .padding(.horizontal)
                    Text("완료")
                        .foregroundColor(.white)
                }
            }

        }
    }
}

struct AccountSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSetupView().preferredColorScheme(.light)
    }
}
