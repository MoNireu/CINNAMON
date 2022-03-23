//
//  CinnamonApp.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/01/03.
//

import SwiftUI
import Firebase

@main
struct CinnamonApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
//            SignInUpView(viewModel: SignInUpViewModel())
//            AccountSetupView(viewModel: AccountSetupViewModel())
            let store = ExtractRecipeStore()
            ExtractRecipeListView(viewModel: ExtractRecipeListViewModel(extractRecipeListData: store)).environmentObject(store)
//            ExtractRecipeDetailView(viewModel: ExtractRecipeDetailViewModel())
        }
    }
}
