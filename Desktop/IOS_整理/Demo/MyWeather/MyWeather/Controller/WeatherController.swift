//
//  ViewController.swift
//  MyWeather
//
//  Created by Lung on 2019/9/9.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class WeatherController: UIViewController {
    @IBOutlet weak var WeatherTableView: UITableView!
    
    var ViewModel = WeatherViewModel()
    var util = IphoneModel()
    
    var weatherView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設置 cell 點擊顏色
        self.weatherView.backgroundColor = .none
        //self.title = "各縣市氣象預報"
        navigationSetup()
        weatherSetup()
        self.ViewModel.getWeatherData()
        closureSetUp()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension WeatherController: UITableViewDelegate, UITableViewDataSource{
    // tableview setup
    func weatherSetup(){
        WeatherTableView.delegate = self
        WeatherTableView.dataSource = self
        WeatherTableView.separatorStyle = .none
        WeatherTableView.rowHeight = 200
        WeatherTableView.backgroundColor = .white
    }
    // model
    func closureSetUp() {
        ViewModel.reloadWeather = { [weak self] ()  in
            DispatchQueue.main.async {
                self?.WeatherTableView.reloadData()
            }
        }
        ViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
            }
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewModel.location.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell") as! WeatherTableViewCell
        
        // 縣市
        let locationName = ViewModel.location[indexPath.row].locationName
        
        // 日期
        let DateTime: String = ViewModel.location[indexPath.row].weatherElement[0].time[0].startTime!
        let Date: [String] = DateTime.components(separatedBy: " ")
        
        // 舒適度
        let Pop = "舒適度：" + ViewModel.location[indexPath.row].weatherElement[1].time[0].parameter.parameterName! + "%"
        
        // 最低溫度
        let MinT: String = ViewModel.location[indexPath.row].weatherElement[2].time[0].parameter.parameterName! + "℃"
        
        // 最高溫度
        let MaxT: String = ViewModel.location[indexPath.row].weatherElement[4].time[0].parameter.parameterName! + "℃"
        
        // 天氣現象 + 舒適度
        let Wx_Cl: String = ViewModel.location[indexPath.row].weatherElement[0].time[0].parameter.parameterName! + "，" + ViewModel.location[indexPath.row].weatherElement[3].time[0].parameter.parameterName!
        
        // 天氣現象
        let Wx: String = ViewModel.location[indexPath.row].weatherElement[0].time[0].parameter.parameterName!
        
        cell.locationName.text = locationName
        cell.startTime.text = Date[0]
        cell.Pop.text = Pop
        cell.Temp.text = MinT + "~" + MaxT
        cell.Wx_Cl.text = Wx_Cl
        if Wx.contains("晴") {
            cell.weatherImage.image = UIImage(named: "city_weather_pic_sun")
        }else if Wx.contains("雨"){
            cell.weatherImage.image = UIImage(named: "city_weather_pic_rain")
        }else{
            cell.weatherImage.image = UIImage(named: "city_weather_pic_cloud")
        }
        
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        cell.selectedBackgroundView = weatherView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = WeatherTableView.indexPathForSelectedRow {
                let eng = segue.destination as! DetailsController
                eng.countyName = ViewModel.location[indexPath.row].locationName!
            }
        }
    }
}
