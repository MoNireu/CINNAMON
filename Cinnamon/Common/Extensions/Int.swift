//
//  Int.swift.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/10.
//

import Foundation

extension Int {
    func toMinuteString() -> String {
        let minute = Int(self / 60)
        let second = self % 60
        
        return "\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
}
