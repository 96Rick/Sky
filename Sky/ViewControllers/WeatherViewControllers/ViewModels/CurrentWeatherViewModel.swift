//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by Rick on 2018/9/13.
//  Copyright © 2018 cn.rick96. All rights reserved.
//


import UIKit

struct CurrentWeatherViewModel {
    var isLocationReady = false
    var isWeatherReady = false
    var isUpdateReady: Bool {
        return isWeatherReady && isLocationReady
    }
    var location: Location! {
        didSet {
            if location != nil {
                self.isLocationReady = true
            } else {
                self.isLocationReady = false
            }
        }
    }
    var weather: WeatherData! {
        didSet {
            if weather != nil {
                self.isWeatherReady = true
            } else {
                self.isWeatherReady = false
            }
        }
    }
    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        return String(
            format: "%.1f °C",
            weather.currently.temperature.toCelcius())
    }
    
    var weatherIcon: UIImage {
        return UIImage.getWeatherIcon(of: weather.currently.icon)!
    }
    
    
    var humidity: String {
        return String(
            format: "%.1f %%",
            weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatterDay = DateFormatter()
        let lan = UserDefaults.getCurrentLanguage()
        switch lan {
        case "EN":
            formatterDay.dateFormat = "MMM d "
        case "CN":
            formatterDay.dateFormat = "M月d"
        default:
            formatterDay.dateFormat = "MMM d "
        }
        
        let frontDateText = formatterDay.string(from: weather.currently.time)
        
        let formatterWeek = DateFormatter()
        formatterWeek.dateFormat = "EEE"
        var behindDateText = formatterWeek.string(from: weather.currently.time)
        behindDateText.toCnWeek()
        
        return frontDateText + behindDateText
    }
    
    
}
