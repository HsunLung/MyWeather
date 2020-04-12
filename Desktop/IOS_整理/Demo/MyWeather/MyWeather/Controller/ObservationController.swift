//
//  ObservationController.swift
//  MyWeather
//
//  Created by Lung on 2019/12/10.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class ObservationController: UIViewController {

    @IBOutlet weak var observationTableview: UITableView!
    
    var util = IphoneModel()
    
    let ObservationText: [String] = ["雷達回波", "衛星雲圖", "累積雨量圖", "溫度分布圖", "紫外線測報", "即時閃電"]
    let ObservationImage: [String] = ["https://www.cwb.gov.tw/Data/radar/CV1_TW_1000_forPreview.png", "https://www.cwb.gov.tw/Data/satellite/LCC_VIS_TRGB_1000/LCC_VIS_TRGB_1000_forPreview.jpg", "https://www.cwb.gov.tw/Data/rainfall/QZJ_forPreview.jpg", "https://www.cwb.gov.tw/Data/temperature/temp_forPreview.jpg", "https://www.cwb.gov.tw/Data/UVI/UVI_forPreview.png", "https://www.cwb.gov.tw/Data/lightning/lightning_s_forPreview.jpg"]
    let ObservationTextTwo: [String] = ["今日排行榜", "前100大雨量", "縣市最大雨量", "前100名溫度資料", "縣市溫度極值資料"]
    
    var observationView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置 cell 點擊顏色
        self.observationView.backgroundColor = .none
        tableviewSetup()
        navigationSetup()
    }
}
extension ObservationController: UITableViewDelegate, UITableViewDataSource {
    func tableviewSetup() {
        observationTableview.delegate = self
        observationTableview.dataSource = self
//        observationTableview.rowHeight = 370
    }
    
    // navigation width height color
    func navigationSetup(){
        let width: CGFloat = self.view.frame.width
        var height: CGFloat = 0

        if util.modelName == "identifier" {
            height = 44
        }else{
            height = 20
        }

        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: height))

        navigationBar.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)

        self.view.addSubview(navigationBar)
     }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 370
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return ObservationText.count
        case 1:
            return ObservationTextTwo.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "observationCell") as! ObservationTableViewCell
            
            if let imageUrl = URL(string: ObservationImage[indexPath.row]) {
                DispatchQueue.global().async {
                    do{
                        let imageData = try Data(contentsOf: imageUrl)
                        let downloadImage = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            cell.observationImageView.image = downloadImage
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            cell.observationText.text = self.ObservationText[indexPath.row]
            
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
            cell.selectedBackgroundView = observationView
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "observationTwoCell") as! ObservationTwoTableViewCell
            
            cell.observationText.text = ObservationTextTwo[indexPath.row]
            
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
            cell.selectedBackgroundView = observationView
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWebview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebview" {
            if let indexPath = observationTableview.indexPathForSelectedRow {
                let eng = segue.destination as! WebViewController
                switch indexPath.section {
                case 0:
                    eng.observationText = self.ObservationText[indexPath.row]
                    break
                case 1:
                    eng.observationText = self.ObservationTextTwo[indexPath.row]
                    break
                default:
                    break
                }
                
            }
        }
    }
}
