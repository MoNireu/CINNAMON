//
//  ContentView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/01/03.
//

import SwiftUI
import CoreData



struct SignInUpView: View {
    
    var body: some View {
        VStack() {
            Spacer()
            Spacer()
            
            Text("CINNAMON")
                .font(.title)
            
            Spacer()
            
            SignInButtonsView()
            
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
