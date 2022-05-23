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
            TabView {
                ExtractRecipeListView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("레시피 목록")
                    }
            }
//            SignInUpView(viewModel: SignInUpViewModel())
//            AccountSetupView(viewModel: AccountSetupViewModel())
//            ExtractRecipeDetailView(viewModel: ExtractRecipeDetailViewModel())
//            CreateExtractRecipeView(viewModel: ExtractRecipeListViewModel(usecase: ExtractRecipeListUseCase()))
//            ExtractRecipeExecuteView(recipe: ExtractRecipeDummyData.extractRecipeList[0])
        }
    }
}
