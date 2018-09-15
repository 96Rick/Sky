//
//  ForecastData.swift
//  Sky
//
//  Created by Rick on 2018/9/15.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    let date: Date
    let temperatureLow: Double
    let temperatureHeigh: Double
    let icon: String
    let humidity: Double 
}
