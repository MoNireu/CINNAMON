//
//  SignInButtonsView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/15.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct SignInButtonStackView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var viewModel: SignInUpViewModel
    @Binding var isShown: Bool
    
    var body: some View {
        VStack {
            SignInButtonView(
                title: "Apple로 로그인",
                image: Image("Logo - SIWA - Left-aligned - White - Medium")) {
                    viewModel.signInWithApple()
                }
            
            SignInButtonView(
                title: "Google로 로그인",
                image: Image("SignInWithGoogle").resizable().padding()) {
                    print("Log -", #fileID, #function, #line, "Google 로그인")
                }
            
            SignInButtonView(
                title: "이메일로 로그인",
                image: Image(systemName: "envelope.fill").resizable().renderingMode(.original).foregroundColor(.white).padding()) {
                    print("Log -", #fileID, #function, #line, "이메일로 로그인")
                }
        }
        .frame(height: 300.0)
    }
}

struct SignInButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonStackView(viewModel: SignInUpViewModel(), isShown: Binding.constant(false))
    }
}
