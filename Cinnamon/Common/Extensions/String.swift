//
//  String.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/26.
//

import Foundation


extension String {
    func doesMatch(pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
