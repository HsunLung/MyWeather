//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Lung on 2019/9/12.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var locationName: UILabel! // 縣市
    @IBOutlet weak var startTime: UILabel! // 日期
    @IBOutlet weak var Wx_Cl: UILabel! // 天氣現象 + 舒適度
    @IBOutlet weak var Temp: UILabel! // 溫度
    @IBOutlet weak var Pop: UILabel! // 降雨機率
    @IBOutlet weak var weatherImage: UIImageView!
    
    var cornerRadius: CGFloat = 15
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 3
    var shadowOpacity: Float = 0.5
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        TextSetup()
        ImageSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func TextSetup(){
        locationName.textColor = .black
        startTime.textColor = .black
        Wx_Cl.textColor = .black
        Temp.textColor = .black
        Pop.textColor = .black
    }
    
    func ImageSetup(){
        // image 透明度
        self.weatherImage.alpha = 0.5
        
        // image 貼合設置size
        self.weatherImage.layer.contentsGravity = CALayerContentsGravity.resize
        
        // 設定layer的圓角
        self.weatherImage.layer.cornerRadius = cornerRadius
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        // masksToBounds屬性若被設置為true，會將超過邊筐外的sublayers裁切掉
        //self.weatherImage.layer.masksToBounds = false
        
        // 陰影設置位置
        self.weatherImage.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        
        // 設定layer shadow的透明度
        self.weatherImage.layer.shadowOpacity = shadowOpacity
        
        // 陰影路徑
        self.weatherImage.layer.shadowPath = shadowPath.cgPath
    }
}
