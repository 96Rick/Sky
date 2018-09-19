 //
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by Rick on 2018/9/15.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import Foundation
import UIKit

 struct WeekWeatherViewModel {
    
    var weatherData: [ForecastData]
    
    private let dateFormattor = DateFormatter()
    
    func week(for index: Int) -> String {
        dateFormattor.dateFormat = "EEE"
        var weekStr = dateFormattor.string(from: weatherData[index].time)
        weekStr.toCnWeek()
        return weekStr
    }
    
    func date(for index: Int) -> String {
        let lan = UserDefaults.getCurrentLanguage()
        switch lan {
        case "EN":
            dateFormattor.dateFormat = "MMM d "
        case "CN":
            dateFormattor.dateFormat = "M月d号 "
        default:
            dateFormattor.dateFormat = "MMM d "
        }
        return dateFormattor.string(from: weatherData[index].time)
    }
    
    func temperature(for index: Int) -> String {
        let min = String(format: "%.0f °C",
                         weatherData[index].temperatureLow.toCelcius())
        let max = String(format: "%.0f °C",
                         weatherData[index].temperatureHigh.toCelcius())
        return "\(min) — \(max)"
    }
    
    func weatherIcon(for index: Int) -> UIImage? {
        return UIImage.getWeatherIcon(of: weatherData[index].icon)
    }
    
    func humidity(for index: Int) -> String {
        return String(format: "%.0f %%", weatherData[index].humidity)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
    }
 }
