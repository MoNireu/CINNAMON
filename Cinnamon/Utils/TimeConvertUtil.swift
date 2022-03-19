//
//  TimeStringUtil.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/03/18.
//

import Foundation
import SwiftUI

//class TimeConvertUtil {
//
//    static let shared = TimeConvertUtil()
//
//    func timeIntToString(time: Int) -> String {
//        return getTimeStringByTimeInt(time)
//    }
//
//    func timeIntToString(time: Binding<Int>) -> Binding<String> {
//        let time = time.wrappedValue
//        return .constant(getTimeStringByTimeInt(time))
//    }
//
//    func timeToSecond(minute: Int, second: Int) -> Int {
//        return minute * 60 + second
//    }
//
//    private func getTimeStringByTimeInt(_ time: Int) -> String {
//        let minute = Int(time / 60)
//        let second = time % 60
//        let minuteString = "\(String(format: "%02d", minute))분"
//        let secondString = "\(String(format: "%02d", second))초"
//
//        if minute == 0 { return secondString }
//        else { return "\(minuteString) \(secondString)" }
//    }
//}

enum TimeConvertUtil {
    static func timeIntToString(time: Int) -> String {
        return getTimeStringByTimeInt(time)
    }

    static func timeIntToString(time: Binding<Int>) -> Binding<String> {
        let time = time.wrappedValue
        return .constant(getTimeStringByTimeInt(time))
    }

    static func timeToSecond(minute: Int, second: Int) -> Int {
        return minute * 60 + second
    }

    static private func getTimeStringByTimeInt(_ time: Int) -> String {
        let minute = Int(time / 60)
        let second = time % 60
        let minuteString = "\(String(format: "%02d", minute))분"
        let secondString = "\(String(format: "%02d", second))초"

        if minute == 0 { return secondString }
        else { return "\(minuteString) \(secondString)" }
    }
}
