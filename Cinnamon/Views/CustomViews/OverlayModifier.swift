//
//  OverlayModifier.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/20.
//

import SwiftUI

struct OverlayModifier<OverlayView: View>: ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder var overlayView: () -> OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView() : nil)
    }
}

struct BottomPopupView<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        VStack {
            Spacer()
                .onTapGesture {
                    isPresented.toggle()
                }
            content()
                .background(Color.white)
                .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
                .shadow(radius: 10)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension View {
    
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                  backgroundOpacity: CGFloat = 0.5,
                                  blurRadius: CGFloat = 3,
                                  blurAnimation: Animation? = .linear,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        blur(radius: isPresented.wrappedValue ? blurRadius : 0)
            .animation(blurAnimation, value: isPresented.wrappedValue)
            .allowsHitTesting(!isPresented.wrappedValue)
            .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
    }
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}

struct RoundedCornersShape: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
