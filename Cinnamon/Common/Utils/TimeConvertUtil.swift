//
//  TimeStringUtil.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/18.
//

import Foundation
import SwiftUI

struct TimeConvertUtil {
    static let shared = TimeConvertUtil()
    private init() { }
    
    func timeIntToString(time: Int) -> String {
        let minuteSecond = getMinuteSecondStringByTimeInt(time)
        let minuteString = "\(String(format: "%02d", minuteSecond.minute))분"
        let secondString = "\(String(format: "%02d", minuteSecond.second))초"

        if minuteSecond.minute == 0 { return secondString }
        else { return "\(minuteString) \(secondString)" }
    }

    func timeToSecond(minute: Int, second: Int) -> Int {
        return minute * 60 + second
    }

    func getMinuteSecondStringByTimeInt(_ time: Int) -> (minute: Int, second: Int) {
        let minute = Int(time / 60)
        let second = time % 60
        
        return (minute: minute, second: second)
    }
}
