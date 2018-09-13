//
//  String.swift
//  Sky
//
//  Created by Rick on 2018/9/13.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation

extension String {
    mutating func toCnWeek() {
        switch self {
        case "Mon", "Monday":
            self = "星期一"
        case "Tue", "Tuesday":
            self = "星期二"
        case "Wed", "Wednesday":
            self = "星期三"
        case "Thu", "Thursday":
            self = "星期四"
        case "Fri", "Friday":
            self = "星期五"
        case "Sat", "Saturday":
            self = "星期六"
        case "Sun", "Sunday":
            self = "星期日"
        default:
            self = "——"
        }
    }
    
}
