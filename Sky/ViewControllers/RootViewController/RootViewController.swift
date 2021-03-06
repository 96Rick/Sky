//
//  ViewController.swift
//  Sky
//
//  Created by Rick on 2018/9/9.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    private let segueCurrentWeather = "segueCurrentWeather"
    private let segueWeekWeather = "segueWeekWeather"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller.")
            }
    
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("segue failed")
            }
            
            weekWeatherViewController = destination
        
        default:
            break
        }
    }
    
    private var currentLocation: CLLocation? {
        didSet {
            //Fetch the city name
            print("begain fetch city")
            fetchCity()
            
            //Fetch the weather data
            fetchWeather()
            print("fetched weather")
        }
    }
    
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon, completion: {
            response, error in
            if let error = error {
                dump(error)
            } else if let response = response {
                // Notify CurrentWeatherController
                self.currentWeatherViewController.viewModel?.weather = response
//                print(response)
                
                // FIXME: a problem
                self.weekWeatherViewController.viewModel = WeekWeatherViewModel(weatherData: response.daily.data)
            }
        })
    }
    
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: {
            placemarks, error in
            
            if let error = error {
                print("error")
                dump(error)
            } else if let city = placemarks?.first?.locality {
//                 Notify currentWeatherViewController
                let l = Location(
                    name: city,
                    latitude: currentLocation.coordinate.latitude,
                    longitude: currentLocation.coordinate.longitude)
                self.currentWeatherViewController.viewModel?.location = l
            }
        })
    }

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    
    func requestLocation() {
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
             locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActiveNotification()
    }

    @objc func applicationDidBecomeAcitve(notification: Notification) {
        // request User location
        requestLocation()
    }
    
    private func setupActiveNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RootViewController.applicationDidBecomeAcitve(notification:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }

}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location \(location)")
            currentLocation = location
            manager.delegate = nil
//
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: WeatherViewController) {
        print("Open location")
    }
    
    func settingsButtonPressed(controller: WeatherViewController) {
        print("Open setting")
    }
    
    
}
