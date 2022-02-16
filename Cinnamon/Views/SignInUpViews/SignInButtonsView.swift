//
//  SignInButtonsView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/15.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct SignInButtonsView: View {
    var viewModel: SignInUpViewModel
    @Binding var isShown: Bool
    
    private let BUTTON_WIDTH: CGFloat = 120.0
    private let BUTTON_SIDE_MARGIN: CGFloat = 30.0
    
    var body: some View {
        VStack {
            SignInWithAppleButton(.signIn) { request in
                viewModel.requestSignInWithApple(request)
            } onCompletion: { result in
                switch result {
                case .success(let authorization):
                    viewModel.signInWithFirebase(authorization: authorization)
                case .failure(let error):
                    print("Authorisation failed: \(error.localizedDescription)")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 50.0)
            .cornerRadius(10.0)
            .padding(.leading, BUTTON_SIDE_MARGIN)
            .padding(.trailing, BUTTON_SIDE_MARGIN)
            
            Button {
                print("Log -", #fileID, #function, #line, "Apple 로그인")
            } label: {
                HStack {
                    Image(systemName: "applelogo")
                        .resizable()
                        .scaledToFit()
                    Text("Apple 로그인")
                        .frame(maxWidth: BUTTON_WIDTH)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, BUTTON_SIDE_MARGIN)
            .padding(.trailing, BUTTON_SIDE_MARGIN)
            
            
            Button {
                print("Log -", #fileID, #function, #line, "Google 로그인")
            } label: {
                HStack {
                    Image("SignInWithGoogle")
                        .resizable()
                        .scaledToFit()
                    Text("Google 로그인")
                        .frame(maxWidth: BUTTON_WIDTH)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, BUTTON_SIDE_MARGIN)
            .padding(.trailing, BUTTON_SIDE_MARGIN)
            
            
            Button {
                print("Log -", #fileID, #function, #line, "이메일 로그인")
                isShown.toggle()
            } label: {
                HStack {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .scaledToFit()
                    Text("이메일 로그인")
                        .frame(maxWidth: BUTTON_WIDTH)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50.0)
                .font(.headline)
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(10.0)
            }
            .padding(.leading, BUTTON_SIDE_MARGIN)
            .padding(.trailing, BUTTON_SIDE_MARGIN)
            
        }
        .frame(height: 300.0)
    }
}

struct SignInButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonsView(viewModel: SignInUpViewModel(), isShown: Binding.constant(false))
    }
}
