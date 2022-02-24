//
//  SignInButtonsView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/15.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import GoogleSignIn

struct SignInButtonStackView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var viewModel: SignInUpViewModel
    @Binding var showSignInField: Bool
    
    var body: some View {
        VStack {
            SignInButtonView(
                title: "Apple로 로그인",
                image: Image("Logo - SIWA - Left-aligned - \(colorScheme == .dark ? "Black" : "White") - Medium").resizable(),
                action: {
                    print("Log -", #fileID, #function, #line, "Apple로 로그인")
                    viewModel.signInWithApple()
                })
            
            SignInButtonView(
                title: "Google로 로그인",
                image: Image("SignInWithGoogle").resizable().padding(),
                action: {
                    print("Log -", #fileID, #function, #line, "Google 로그인")
                    viewModel.signInWithGoogle()
                })
            
            SignInButtonView(
                title: "이메일로 로그인",
                image: Image(systemName: "envelope.fill")
                    .resizable()
                    .renderingMode(.original)
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .padding(),
                action: {
                    print("Log -", #fileID, #function, #line, "이메일로 로그인")
                    showSignInField = true
                })
        }
        .frame(height: 300.0)
    }
}

struct SignInButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        SignInButtonStackView(viewModel: SignInUpViewModel(), showSignInField: Binding.constant(false))
    }
}
