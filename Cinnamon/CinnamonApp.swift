//
//  CinnamonApp.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/01/03.
//

import SwiftUI

@main
struct CinnamonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SignInUpView(viewModel: SignInUpViewModel())
        }
    }
}
