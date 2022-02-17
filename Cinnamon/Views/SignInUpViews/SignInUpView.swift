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
        
        VStack {
            Spacer()
            Spacer()
            
            Text("CINNAMON")
                .font(.title)
            
            ZStack {
                SignInButtonStackView(viewModel: viewModel,
                                  isShown: $viewModel.showSignInField)
                    .opacity(viewModel.showSignInField ? 0 : 1)
                    .animation(Animation
                                .easeInOut(duration: ANIMATION_DURATION)
                                .delay(viewModel.showSignInField ? 0 : ANIMATION_DURATION),
                               value: viewModel.showSignInField)
                
                SignInFieldView (
                    id: $viewModel.id,
                    password: $viewModel.password,
                    isShown: $viewModel.showSignInField
                )
                    .opacity(viewModel.showSignInField ? 1 : 0)
                    .animation(Animation
                                .easeInOut(duration: ANIMATION_DURATION)
                                .delay(viewModel.showSignInField ? ANIMATION_DURATION : 0),
                               value: viewModel.showSignInField)
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
