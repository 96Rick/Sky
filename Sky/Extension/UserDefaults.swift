//
//  UserDefaults.swift
//  Sky
//
//  Created by Rick on 2018/9/14.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {
    static func getCurrentLanguage() -> String {
        if let languages = UserDefaults.standard.object(forKey: "AppleLanguages") as? Array<String> {
            var currentLan = languages[0]
//            en-CN 或en  英文
//            zh-Hans-CN或zh-Hans  简体中文
//            zh-Hant-CN或zh-Hant  繁体中文
//            ja-CN或ja  日本
            print(currentLan)
            
            switch currentLan {
            case "en-CN", "en":
                currentLan = "EN"
            case "zh-Hans-CN", "zh-Hans":
                currentLan = "CN-Sim"
            case "zh-Hant-CN", "zh-Hant":
                currentLan = "CN-Com"
            case "ja-CN", "ja":
                currentLan = "JAP"
            default:
                currentLan = "EN"
            }
            return currentLan
        }
        return "EN"
    }
}
