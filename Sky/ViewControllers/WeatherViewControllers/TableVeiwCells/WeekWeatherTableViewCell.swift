//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by Rick on 2018/9/15.
//  Copyright © 2018 cn.rick96. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {

    static let reuseIdentifi = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tempertuare: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humid: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
