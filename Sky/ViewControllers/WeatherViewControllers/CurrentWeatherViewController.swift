 //
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Rick on 2018/9/10.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import UIKit

 protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: WeatherViewController)
    func settingsButtonPressed(controller: WeatherViewController)
 }
 
class CurrentWeatherViewController: WeatherViewController {

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func locationButtonDidPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonDidPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self )
    }
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    var viewModel: CurrentWeatherViewModel? {
        didSet {
            DispatchQueue.main.async { self.updateView()}
        }
    }
    
    func updateView() {
        
        if let vm = viewModel, vm.isUpdateReady {
            updateWeatherContainer(with: vm)
        } else {
            loadingFailedLabel.isHidden = true
            loadingFailedLabel.text = "Fetch weather / Location Failed"
        }
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    func updateWeatherContainer(with vm: CurrentWeatherViewModel) {
        weatherContainerView.isHidden = false
    
        locationLabel.text = vm.city
        temperatureLabel.text = vm.temperature
        weatherIcon.image = vm.weatherIcon
        humidityLabel.text = vm.humidity
        summaryLabel.text = vm.summary
        dateLabel.text = vm.date
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
