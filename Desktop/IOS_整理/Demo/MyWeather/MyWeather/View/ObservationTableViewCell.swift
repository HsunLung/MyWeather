//
//  ObservationTableViewCell.swift
//  MyWeather
//
//  Created by Lung on 2019/12/10.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class ObservationTableViewCell: UITableViewCell {

    @IBOutlet weak var observationText: UILabel!
    @IBOutlet weak var observationImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ImageSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func ImageSetup() {
        observationImageView.contentMode = .scaleToFill
    }
}
