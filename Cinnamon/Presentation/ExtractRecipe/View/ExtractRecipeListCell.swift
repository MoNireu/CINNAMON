//
//  ExtractRecipeListCell.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import SwiftUI

struct ExtractRecipeListCell: View {
    var title: String
    var description: String?
    var time: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.system(.title2))
                    .padding(.bottom, 2.0)
                if let description = description {
                    Text(description)
                        .font(.system(.body))
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            Spacer()
            
            Text(time.toMinuteString())
                .padding(.trailing)
                .font(.system(.headline))
        }
    }
}

struct ExtractRecipeListCell_Previews: PreviewProvider {
    static var previews: some View {
        ExtractRecipeListCell(title: "초간단 브루잉 레시피", description: "1분 30초만에 따라하는 초간단 레시피", time: 90)
    }
}
