//
//  TimeStringUtil.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/18.
//

import Foundation
import SwiftUI

class TimeStringUtil {
    static func timeToString(time: Int) -> String {
        let minute = Int(time / 60)
        let second = time % 60
        
        return "\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
    }
    
    static func timeToString(time: Binding<Int>) -> Binding<String> {
        let time = time.wrappedValue
        let minute = Int(time / 60)
        let second = time % 60
        let returnString = "\(String(format: "%02d", minute)):\(String(format: "%02d", second))"
        
        return .constant(returnString)
    }
}
