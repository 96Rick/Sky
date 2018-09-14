//
//  String.swift
//  Sky
//
//  Created by Rick on 2018/9/13.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    mutating func toCnWeek() {
        
        let currentLanguage = UserDefaults.getCurrentLanguage()
        switch currentLanguage {
        case "CN-Sim", "CN-Com":
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
            
        case "EN":
            switch self {
            case "Mon", "Monday":
                self = "Monday"
            case "Tue", "Tuesday":
                self = "Tuesday"
            case "Wed", "Wednesday":
                self = "Wednesday"
            case "Thu", "Thursday":
                self = "Thursday"
            case "Fri", "Friday":
                self = "Friday"
            case "Sat", "Saturday":
                self = "Saturday"
            case "Sun", "Sunday":
                self = "Sunday"
            default:
                self = "——"
            }
            
        case "JAP":
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
        
        default:
            switch self {
            case "Mon", "Monday":
                self = "Monday"
            case "Tue", "Tuesday":
                self = "Tuesday"
            case "Wed", "Wednesday":
                self = "Wednesday"
            case "Thu", "Thursday":
                self = "Thursday"
            case "Fri", "Friday":
                self = "Friday"
            case "Sat", "Saturday":
                self = "Saturday"
            case "Sun", "Sunday":
                self = "Sunday"
            default:
                self = "——"
            }
        }
        
    }
    
}
