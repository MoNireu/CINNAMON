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
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Spacer()
                
                Text("CINNAMON")
                    .font(.title)
                    .padding(.bottom, 100.0)
                
                SignInButtonsView(isShown: $showSignInField)
                    
                Spacer()
            }
            
            if showSignInField {
                Color.black.opacity(0.7)
                    .ignoresSafeArea()
                
                SignInFieldView(id: $id, password: $password, isShown: $showSignInField)
            }
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
