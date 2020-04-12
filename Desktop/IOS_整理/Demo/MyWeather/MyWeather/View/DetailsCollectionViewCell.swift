//
//  DetailsCollectionViewCell.swift
//  MyWeather
//
//  Created by Lung on 2019/11/6.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class DetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    func TextSetup() {
        week.textColor = .black
        minTemp.textColor = .black
        maxTemp.textColor = .black
    }
    
}
