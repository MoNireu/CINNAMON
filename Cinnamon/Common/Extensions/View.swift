//
//  View.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import Foundation
import SwiftUI


enum ViewVisibility {
    case visible
    case invisible
    case gone
}

extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden { self.hidden() }
        else { self }
    }
    
    @ViewBuilder func visibility(_ viewVisibility: ViewVisibility) -> some View {
        if viewVisibility != .gone {
            if viewVisibility == .visible { self }
            else { hidden() }
        }
    }
}
