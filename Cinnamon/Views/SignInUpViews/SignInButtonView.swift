//
//  SignInButtonView.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/02/17.
//

import SwiftUI

struct SignInButtonView<Icon: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    var title: String
    var image: Icon
    var action: () -> Void
    
    private let BUTTON_WIDTH = 150.0
    private let BUTTON_HEIGHT = 50.0
    private let BUTTON_SIDE_MARGIN = 30.0
    private var BUTTON_BACKGROUND_COLOR: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    private var BUTTON_FORGROUND_COLOR: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    var body: some View {
        HStack {
            Button {
                print("Log -", #fileID, #function, #line, title)
                action()
            } label: {
                image
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT)
                    .padding(.leading, -30.0)
                
                Text(title)
                    .frame(width: BUTTON_WIDTH)
            }
            .frame(maxWidth: .infinity, maxHeight: BUTTON_HEIGHT)
            .font(Font.system(size: BUTTON_HEIGHT * 0.43).weight(.medium))
            .foregroundColor(BUTTON_FORGROUND_COLOR)
            .background(BUTTON_BACKGROUND_COLOR)
            .cornerRadius(10.0)
            .padding(.horizontal, BUTTON_SIDE_MARGIN)
            
        }
    }
}

struct SignInButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignInButtonView(
            title: "Apple로 로그인",
            image: Image("Logo - SIWA - Left-aligned - White - Medium")) {
                print("asdf")
            }
    }
}
