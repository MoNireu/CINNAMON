//
//  SignUpViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/24.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    private var cancellableBag = Set<AnyCancellable>()
    
    @Published var username: String = ""
    var usernameError: String = ""
    @Published var email: String = ""
    var emailError: String = ""
    @Published var password: String = ""
    var passwordError: String = ""
    @Published var confirmPassword: String = ""
    var confirmPasswordError: String = ""
    
    @Published var didEndEditing: Bool = false
    @Published var isButtonDisabled: Bool = true
    
    
    init() {
        setEmptyErrorMsg($username, errorKeyPath: \.usernameError, errorMsg: "Username is missing")
        setEmptyErrorMsg($email, errorKeyPath: \.emailError, errorMsg: "Email is missing")
        setEmptyErrorMsg($password, errorKeyPath: \.passwordError, errorMsg: "Password is missing")
        setEmptyErrorMsg($confirmPassword, errorKeyPath: \.confirmPasswordError, errorMsg: "Confirmed Password is missing")
        usernameError = ""
        emailError = ""
        passwordError = ""
        confirmPasswordError = ""
        
        $didEndEditing.sink { didEndEditing in
            print("Log -", #fileID, #function, #line, "Valid Check")
            if didEndEditing {
                if !self.username.isEmpty,
                    !self.email.isEmpty,
                    !self.password.isEmpty,
                    !self.confirmPassword.isEmpty {
                    print("Log -", #fileID, #function, #line, "Button Enabled")
                    self.isButtonDisabled = false
                }
                else {
                    print("Log -", #fileID, #function, #line, "Button Disabled")
                    self.isButtonDisabled = true
                }
            }
            else {
                print("Log -", #fileID, #function, #line, "Button Disabled")
                self.isButtonDisabled = true
            }
        }
        .store(in: &cancellableBag)
    }
    
    // MARK: - 1st Method
    func setEmptyErrorMsg(_ field: Published<String>.Publisher, errorKeyPath: ReferenceWritableKeyPath<SignUpViewModel, String>, errorMsg: String) {
        field
            .map{!$0.isEmpty}
            .map { $0 ? "" : errorMsg }
            .assign(to: errorKeyPath, on: self)
            .store(in: &cancellableBag)
        
        field.sink(receiveValue: { _ in self.didEndEditing = false })
            .store(in: &cancellableBag)
    }
}
