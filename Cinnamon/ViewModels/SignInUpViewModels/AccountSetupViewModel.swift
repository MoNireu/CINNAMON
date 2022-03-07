//
//  AccountSetupViewModel.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/07.
//

import Foundation
import Combine


class AccountSetupViewModel: ObservableObject {
    @Published var myId: String = ""
    @Published var isCompleteButtonDisabled = true
    private var isIdVerified = false
    
    func verifyId() {
        print("Log -", #fileID, #function, #line, "아이디: \(myId)")
        enableCompleteButton()
    }
    
    func disableCompleteButton() {
        isCompleteButtonDisabled = true
    }
    
    func enableCompleteButton() {
        isCompleteButtonDisabled = false
    }
}
