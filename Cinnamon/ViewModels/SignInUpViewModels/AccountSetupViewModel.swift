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
    @Published var isCheckBoxChecked = false
    @Published var isCompleteButtonDisabled = true
    @Published var isVerifying = false
    private var isIdVerified = false
    private var isAllFieldVerified: Bool {
        return isIdVerified && isCheckBoxChecked ? true : false
    }
    
    func verifyId() {
        print("Log -", #fileID, #function, #line, "아이디: \(myId)")
        if myId.isEmpty { isIdVerified = false }
        else { isIdVerified = true }
        changeCompleteButtonState()
    }
    
    func changeCompleteButtonState() {
        isAllFieldVerified ? enableCompleteButton() : disableCompleteButton()
    }
    
    func disableCompleteButton() {
        isCompleteButtonDisabled = true
    }
    
    func enableCompleteButton() {
        isCompleteButtonDisabled = false
    }
}
