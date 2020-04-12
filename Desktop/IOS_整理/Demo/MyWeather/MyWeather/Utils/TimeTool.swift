//
//  TimeTool.swift
//  MyWeather
//
//  Created by Lung on 2019/10/16.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation

class TimeTool {
    static let calender = Calendar.current
    static let df = DateFormatter()
    
    static func getThisY() -> Int {
        // 取得今年
        let dateCom = calender.dateComponents(Set([Calendar.Component.year]), from: Date())
        return dateCom.year!
    }
    static func getThisM() -> Int {
        // 取得這個月
        let dateCom = calender.dateComponents(Set([Calendar.Component.month]), from: Date())
        return dateCom.month!
    }
    static func getThisD() -> Int {
        // 取得今日
        let dateCom = calender.dateComponents(Set([Calendar.Component.day]), from: Date())
        return dateCom.day!
    }
    static func getThisW() -> Int {
        // 取得禮拜幾
        let dateCom = calender.dateComponents(Set([Calendar.Component.weekday]), from: Date())
        return dateCom.weekday!
    }
    static func getThisH() -> Int {
        // 取得幾點
        let dateCom = calender.dateComponents(Set([Calendar.Component.hour]), from: Date())
        return dateCom.hour!
    }
    static func getThisMin() -> Int {
        // 取得幾分
        let dateCom = calender.dateComponents(Set([Calendar.Component.minute]), from: Date())
        return dateCom.minute!
    }
    static func getThisDayForPayment() -> String{
        let today = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let dateString = dateFormat.string(from: today)
        return dateString
        
    }
}
