//
//  CheckBoxView.swift.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/07.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool
    
    var body: some View {
        Image(systemName: isChecked ? "checkmark.square" : "square")
            .font(.system(.title2))
            .foregroundColor(isChecked ? .green : .gray)
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(isChecked: Binding<Bool>.constant(false))
    }
}
