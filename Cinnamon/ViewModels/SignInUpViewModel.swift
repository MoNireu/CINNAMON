//
//  SignInUpViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/16.
//

import Foundation


class SignInUpViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var showSignInField: Bool = false
}
