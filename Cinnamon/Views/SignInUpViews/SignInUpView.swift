//
//  ContentView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/01/03.
//

import SwiftUI
import CoreData
import AuthenticationServices



struct SignInUpView: View {
    @ObservedObject private var viewModel: SignInUpViewModel
    let ANIMATION_DURATION = 0.2
    
    init(viewModel: SignInUpViewModel) {
        self.viewModel = SignInUpViewModel()
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                Spacer()
                
                VStack {
                    Text("CINNAMON")
                        .font(.title)
                    
                    SignInButtonStackView(viewModel: viewModel,
                                          showSignInField: $viewModel.showSignInField)
                }
                Spacer()
            }
            
            if viewModel.showSignInField {
                Group {
                    Color.black.opacity(0.8)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.showSignInField = false
                        }
                    
                    SignInFieldView (
                        id: $viewModel.id,
                        password: $viewModel.password,
                        isShown: $viewModel.showSignInField)
                }
                .transition(.opacity.animation(.easeInOut))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let deviceNames = ["iphone 13 Pro Max", "iPod touch (7th generation)"]
        
        ForEach(deviceNames, id: \.self) {
            SignInUpView(viewModel: SignInUpViewModel())
                .previewDevice(PreviewDevice(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
