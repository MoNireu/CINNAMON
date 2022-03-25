//
//  ContentView.swift
//  SwiftuiCombineExample
//
//  Created by MoNireu on 2022/02/10.
//

import SwiftUI
import Combine

enum SignUpColors {
        static let success = Color(red: 0, green: 0, blue:  0)
        static let failure = Color(red: 219/255, green: 12/255, blue: 12/255)
        static let background = Color(red: 239/255, green: 243/255, blue: 244/255)
}

struct SignUpView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: SignUpViewModel
    @Binding var showSignUp: Bool
    
    private var cancellableBag = Set<AnyCancellable>()
    @State private var buttonDisabled: Bool = true
    
    init(viewModel: SignUpViewModel, showSignUp: Binding<Bool>) {
        self.viewModel = viewModel
        self._showSignUp = .init(projectedValue: showSignUp)
        viewModel.$isButtonDisabled
            .sink { [self] disable in
                self.buttonDisabled = disable
            }
            .store(in: &cancellableBag)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Button {
                    showSignUp.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Text("회원가입")
                    .font(.system(size: 40.0))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.bottom, 20.0)
                
                VStack {
                    AuthTextField(title: "Username",
                                  textValue: $viewModel.username,
                                  didEndEditing: $viewModel.didEndEditing,
                                  errorValue: viewModel.usernameError)
                    AuthTextField(title: "Email",
                                  textValue: $viewModel.email,
                                  didEndEditing: $viewModel.didEndEditing,
                                  errorValue: viewModel.emailError,
                                  keyboardType: .emailAddress)
                    AuthTextField(title: "Password",
                                  textValue: $viewModel.password,
                                  didEndEditing: $viewModel.didEndEditing,
                                  errorValue: viewModel.passwordError,
                                  isSecured: true)
                    AuthTextField(title: "Confirm Password",
                                  textValue: $viewModel.confirmPassword,
                                  didEndEditing: $viewModel.didEndEditing,
                                  errorValue: viewModel.confirmPasswordError,
                                  isSecured: true)
                }
                
                Button(action: signUp) {
                    Text("SignUp")
                }
                .frame(minWidth: 0.0, maxWidth: .infinity)
                .foregroundColor(Color.white)
                .padding()
                .background(buttonColor)
                .cornerRadius(.infinity)
                .padding(.top, 20.0)
                .disabled(viewModel.isButtonDisabled)
                
            }.padding(60.0)
        }
    }
    
    var buttonColor: Color {
        return viewModel.isButtonDisabled ? Color.gray : Color.black
    }
    
    func signUp() {
        print("Log -", #fileID, #function, #line, viewModel.username)
        print("Log -", #fileID, #function, #line, viewModel.email)
        print("Log -", #fileID, #function, #line, viewModel.password)
        print("Log -", #fileID, #function, #line, viewModel.confirmPassword)
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(viewModel: SignUpViewModel(), showSignUp: Binding.constant(true)).previewInterfaceOrientation(.portrait)
    }
}

struct AuthTextField: View {
    var title: String
    @Binding var textValue: String
    @Binding var didEndEditing: Bool
    var errorValue: String
    var isSecured: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        VStack {
            if isSecured {
                SecureField(title, text: $textValue)
                    .padding()
                    .background(SignUpColors.background)
                    .cornerRadius(5.0)
                    .keyboardType(keyboardType)
                    .textContentType(.newPassword)
                    .onSubmit {
                        didEndEditing = true
                    }
            }
            else {
                TextField(title, text: $textValue)
                    .padding()
                    .background(SignUpColors.background)
                    .cornerRadius(5.0)
                    .keyboardType(keyboardType)
                    .onSubmit {
                        didEndEditing = true
                    }
            }
            
            Text(errorValue)
                .fontWeight(.light)
                .foregroundColor(SignUpColors.failure)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
        }
    }
}
