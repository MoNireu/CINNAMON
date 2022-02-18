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
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var viewModel: SignInUpViewModel
    
    let ANIMATION_DURATION = 0.2
    
    init(viewModel: SignInUpViewModel) {
        self.viewModel = SignInUpViewModel()
    }
    
    var transitionColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            
            VStack {
                Text("CINNAMON")
                    .font(.title)
                
                ZStack {
                    SignInButtonStackView(viewModel: viewModel,
                                          showSignInField: $viewModel.showSignInField)
                    
                    transitionColor
                        .frame(height: 300)
                        .opacity(viewModel.showSignInField ? 1 : 0)
                        .animation(.easeInOut(duration: ANIMATION_DURATION)
                                    .delay(viewModel.showSignInField ? 0 : ANIMATION_DURATION),
                                   value: viewModel.showSignInField)
                    
                    SignInFieldView (
                        id: $viewModel.id,
                        password: $viewModel.password,
                        isShown: $viewModel.showSignInField)
                        .opacity(viewModel.showSignInField ? 1 : 0)
                        .animation(.easeInOut(duration: ANIMATION_DURATION)
                                    .delay(viewModel.showSignInField ? ANIMATION_DURATION: 0),
                                   value: viewModel.showSignInField)
                }
            }
            Spacer()
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
