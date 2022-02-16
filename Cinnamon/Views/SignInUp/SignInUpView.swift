//
//  ContentView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/01/03.
//

import SwiftUI
import CoreData



struct SignInUpView: View {
    @State private var id: String = ""
    @State private var password: String = ""
    @State private var showSignInField: Bool = false
    let ANIMATION_DURATION = 0.2
    
    var body: some View {
        
        VStack {
            Spacer()
            Spacer()
            
            Text("CINNAMON")
                .font(.title)
                .padding(.bottom, 100.0)
            
            ZStack {
                SignInButtonsView(isShown: $showSignInField)
                    .opacity(showSignInField ? 0 : 1)
                    .animation(Animation
                                .easeInOut(duration: ANIMATION_DURATION)
                                .delay(showSignInField ? 0 : ANIMATION_DURATION),
                               value: showSignInField)
                
                SignInFieldView(id: $id, password: $password, isShown: $showSignInField)
                    .opacity(showSignInField ? 1 : 0)
                    .animation(Animation
                                .easeInOut(duration: ANIMATION_DURATION)
                                .delay(showSignInField ? ANIMATION_DURATION : 0),
                               value: showSignInField)
            }
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let deviceNames = ["iphone 13 Pro Max", "iPod touch (7th generation)"]
        
        ForEach(deviceNames, id: \.self) {
            SignInUpView()
                .previewDevice(PreviewDevice(rawValue: $0))
                .previewDisplayName($0)
        }
    }
}
