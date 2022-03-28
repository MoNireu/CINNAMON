//
//  View.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import Foundation
import SwiftUI


extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden { self.hidden() }
        else { self }
    }
}