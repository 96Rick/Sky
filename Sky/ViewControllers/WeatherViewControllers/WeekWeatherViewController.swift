//
//  WeekViewController.swift
//  Sky
//
//  Created by Rick on 2018/9/13.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import UIKit

class WeekWeatherViewController: WeatherViewController {

    @IBOutlet weak var weekWeatherTableView: UITableView!
    
    var viewModel: WeekWeatherViewModel? {
        didSet {
            DispatchQueue.main.async { self.updateView() }
        }
    }
    
    func updateView() {
         activityIndicatorView.stopAnimating()
        if let _ = viewModel {
            updateWeatherDataContainer()
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "出错了"
        }
    }
    
    func updateWeatherDataContainer() {
        weatherContainerView.isHidden = false
        weekWeatherTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}


extension WeekWeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekWeatherTableViewCell.reuseIdentifier, for: indexPath) as? WeekWeatherTableViewCell
        
        
        guard let row = cell else { fatalError("cell init failed") }
        
        if let vm = viewModel {
            row.date.text = vm.date(for: indexPath.row)
            row.humid.text = vm.humidity(for: indexPath.row)
            row.temperatuare.text = vm.temperature(for: indexPath.row)
            row.weatherIcon.image = vm.weatherIcon(for: indexPath.row)
            row.week.text = vm.week(for: indexPath.row)
        }
        return row
    }
    
    
}
