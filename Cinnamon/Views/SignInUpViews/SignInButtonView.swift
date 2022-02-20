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
    
    private let TEXTFIELD_WIDTH = 155.0
    private let BUTTON_SIDE_MARGIN = 30.0
    private let BUTTON_HEIGHT = 50.0
    private var BUTTON_WIDTH: Double { UIScreen.main.bounds.width - BUTTON_SIDE_MARGIN * 2 }
    private var BUTTON_BACKGROUND_COLOR: Color {
        colorScheme == .dark ? Color.white : Color.black
    }
    private var BUTTON_FORGROUND_COLOR: Color {
        colorScheme == .dark ? Color.black : Color.white
    }
    
    var body: some View {
            Button {
                print("Log -", #fileID, #function, #line, title)
                action()
            } label: {
                Spacer(minLength: (UIScreen.main.bounds.width - 60) * 0.1)
                image
                    .aspectRatio(contentMode: .fit)
                    .frame(width: BUTTON_HEIGHT, height: BUTTON_HEIGHT, alignment: .center)
                
                Text(title)
                    .frame(width: TEXTFIELD_WIDTH, alignment: .leading)
                    .font(Font.system(size: round(BUTTON_HEIGHT * 0.43)).weight(.medium))
                
                Spacer(minLength: (UIScreen.main.bounds.width - 60) * 0.1)
            }
            .frame(height: BUTTON_HEIGHT)
            .foregroundColor(BUTTON_FORGROUND_COLOR)
            .background(BUTTON_BACKGROUND_COLOR)
            .cornerRadius(10.0)
            .padding(.horizontal, BUTTON_SIDE_MARGIN)
    }
}

struct SignInButtonView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignInButtonView(
            title: "Google로 로그인",
            image: Image("Logo - SIWA - Left-aligned - White - Medium")) {
                print("asdf")
            }
    }
}
