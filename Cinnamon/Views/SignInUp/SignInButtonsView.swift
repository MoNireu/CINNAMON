//
//  SignInButtonsView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/15.
//

import SwiftUI

struct SignInButtonsView: View {
    private let buttonWidth = 120.0
    
    var body: some View {
        VStack {
            Button {
                print("Log -", #fileID, #function, #line, "Apple 로그인")
            } label: {
                HStack {
                    Image(systemName: "applelogo")
                        .resizable()
                        .scaledToFit()
                    Text("Apple 로그인")
                        .frame(maxWidth: buttonWidth)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, 50.0)
            .padding(.trailing, 50.0)
            
            
            Button {
                print("Log -", #fileID, #function, #line, "Google 로그인")
            } label: {
                HStack {
                    Image("SignInWithGoogle")
                        .resizable()
                        .scaledToFit()
                    Text("Google 로그인")
                        .frame(maxWidth: buttonWidth)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, 50.0)
            .padding(.trailing, 50.0)
            
            
            Button {
                print("Log -", #fileID, #function, #line, "일반 로그인")
            } label: {
                HStack {
                    Image(systemName: "lock.open.fill")
                        .resizable()
                        .scaledToFit()
                    Text("일반 로그인")
                        .frame(maxWidth: buttonWidth)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, 50.0)
            .padding(.trailing, 50.0)
        }
    }
}

struct SignInButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonsView()
    }
}
