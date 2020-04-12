//
//  HomeController.swift
//  MyWeather
//
//  Created by Lung on 2019/9/25.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var homeTempText: UILabel!
    @IBOutlet weak var homeAddressText: UILabel!
    @IBOutlet weak var homeWeartherText: UILabel!
    @IBOutlet weak var homeSomatosensoryText: UILabel!
    @IBOutlet weak var homeTimeText: UILabel!
    @IBOutlet weak var homeBackgroundImage: UIImageView!
    
    var ViewModel = OneWeekWeatherViewModel()
    var util = IphoneModel()
    
    // 取得螢幕的尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    
    var activityIndicator: UIActivityIndicatorView!
    
    var weekNum: [String] = []
    var minTemp: [String] = []
    var maxTemp: [String] = []
    var weatherImage: [String] = []
    var countyName: String = ""
    var zoneIndex: Int = 0
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.ViewModel.getCounty(county: countyName)
//
//        TextSetup()
//        HomeSetUp()
//        closureSetUp()
//
////        loadingActivity()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.ViewModel.getCounty(county: countyName)
        navigationSetup()
        BackgroundImageSetup()
        TextSetup()
        HomeSetUp()
        closureSetUp()
   }
    
    override func viewWillDisappear(_ animated: Bool) {
         weekNum = []
         minTemp = []
         maxTemp = []
         weatherImage = []
     }
}
extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    // collection setup
    func HomeSetUp() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.backgroundColor = .clear
        
        tabBarController?.tabBar.barTintColor = #colorLiteral(red: 0, green: 0.231372549, blue: 0.3411764706, alpha: 1)
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        homeCollectionView!.collectionViewLayout = layout
    }
    // text setup
    func TextSetup(){
        homeTempText.textColor = .black
        homeAddressText.textColor = .black
        homeWeartherText.textColor = .black
        homeSomatosensoryText.textColor = .black
        homeTimeText.textColor = .black
        
        homeTempText.text = ""
        homeAddressText.text = ""
        homeWeartherText.text = ""
        homeSomatosensoryText.text = ""
        homeTimeText.text = ""
    }
    // image setup
    func BackgroundImageSetup(){
        // image 透明度
        homeBackgroundImage.alpha = 0.5
        // 設置圖片顯示模式
        homeBackgroundImage.contentMode = .scaleToFill
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
    // model
    func closureSetUp() {
        ViewModel.reloadOneWeekWeather = { [weak self] ()  in
            DispatchQueue.main.async {
                for i in 0...6 {
                    self!.getDay(index: i)
                    self!.getWeatherElement(index: i, condition: "Weather") // 天氣現象
                    self!.getWeatherElement(index: i, condition: "MaxT") // MaxT（最高溫度）
                    self!.getWeatherElement(index: i, condition: "MinT") // MinT（最低溫度）
                  }
                
                // 天氣現象 image
                self!.homeImageView.image = UIImage(named: self!.getWeatherImage(weather: self!.ViewModel.oneweeklocations[0].location[self!.zoneIndex].weatherElement[6].time[0].elementValue[0].value!))
                // 溫度
                let Temp: String = self!.ViewModel.oneweeklocations[0].location[self!.zoneIndex].weatherElement[12].time[0].elementValue[0].value!
                self!.homeTempText.text = "\(Temp)℃"
                // 城市
                let City: String = self!.ViewModel.oneweeklocations[0].locationsName!
                let Area: String = self!.ViewModel.oneweeklocations[0].location[self!.zoneIndex].locationName!
                self!.homeAddressText.text = City + Area
                // 天氣現象
                self!.homeWeartherText.text = self!.ViewModel.oneweeklocations[0].location[self!.zoneIndex].weatherElement[6].time[0].elementValue[0].value
                // 體感溫度
                let Somatosensory: String = self!.ViewModel.oneweeklocations[0].location[self!.zoneIndex].weatherElement[5].time[0].elementValue[0].value!
                
                self!.homeSomatosensoryText.text = "體感\(Somatosensory)℃"
                // 日期
                self!.homeTimeText.text = TimeTool.getThisDayForPayment()
                
                self?.homeCollectionView.reloadData()
//                self?.activityIndicator.stopAnimating()
            }
        }
        ViewModel.errorMessage = { [weak self] (message)  in
            DispatchQueue.main.async {
                print(message)
//                self?.activityIndicator.stopAnimating()
            }
        }
    }
    // loading setup
    func loadingActivity(){
         // 建立一個 UIActivityIndicatorView
         activityIndicator = UIActivityIndicatorView(
             style:.whiteLarge)

         // 環狀進度條的顏色
         activityIndicator.color = .black

         // 底色
         activityIndicator.backgroundColor =
             UIColor.white

         // 設置位置並放入畫面中
         activityIndicator.center = CGPoint(
           x: fullScreenSize.width * 0.5,
           y: fullScreenSize.height * 0.5)
         
         activityIndicator.startAnimating()
         self.view.addSubview(activityIndicator)
     }
    
    func getDay(index: Int){
        let Day = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Day)
        var weekDay = dateComponents.weekday!
        let hour = dateComponents.hour!
        
        if hour >= 18{
            weekDay = weekDay + 1
        }
        weekDay = weekDay + index
        if weekDay > 7{
            weekDay = weekDay - 7
        }
        
        switch weekDay {
        case 1:
            weekNum.append("日")
            break;
        case 2:
            weekNum.append("一")
            break;
        case 3:
            weekNum.append("二")
            break;
        case 4:
            weekNum.append("三")
            break;
        case 5:
            weekNum.append("四")
            break;
        case 6:
            weekNum.append("五")
            break;
        case 7:
             weekNum.append("六")
             break;
        default:
            break;
        }
    }
    
    func getWeatherElement(index: Int, condition: String){
        let Day = Date()
        let dateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Day)
        let hour = dateComponents.hour!
        
        var index = index * 2
        
        if hour >= 6{
            index += 1
        }
        if hour >= 12{
            index -= 1
        }
        
        if condition == "Weather"{
            let weather: String = self.ViewModel.oneweeklocations[0].location[zoneIndex].weatherElement[6].time[index].elementValue[0].value!
            var weatherText: String = ""
            if weather.contains("晴時多雲") {
                weatherText = "晴時多雲"
            }else if weather.contains("多雲時晴") {
                weatherText = "多雲時晴"
            }else if weather.contains("陰") && weather.contains("雨") {
                weatherText = "雨"
            }else if weather.contains("雨") {
                weatherText = "雨"
            }else if weather.contains("多雲") {
                weatherText = "多雲"
            }else if weather.contains("晴") {
                weatherText = "晴"
            }else if weather.contains("陰") {
                weatherText = "陰"
            }else if weather.contains("雷") {
                weatherText = "雷"
            }else if weather.contains("霧") {
                weatherText = "霧"
            }
           
           switch weatherText {
           case "晴":
               weatherImage.append("city_weather_icon_sun_24px")
               break;
           case "晴時多雲":
               weatherImage.append("city_weather_icon_cloudy_sun_24px")
               break;
           case "多雲":
               weatherImage.append("city_weather_icon_cloudy_24px")
               break;
           case "多雲時晴":
               weatherImage.append("city_weather_icon_cloudy_sun_24px")
               break;
           case "雨":
               weatherImage.append("city_weather_icon_rain_24px")
               break;
           case "陰":
               weatherImage.append("city_weather_icon_cloud_24px")
               break;
           case "雷":
               weatherImage.append("city_weather_icon_lightning_rain_24px")
               break;
           case "霧":
               weatherImage.append("city_weather_icon_mist_sun_24px")
               break;
           default:
               weatherImage.append("city_weather_icon_sun_24px")
               break;
           }
        }else if condition == "MaxT"{
            var maxT: String = ""
            maxT = self.ViewModel.oneweeklocations[0].location[zoneIndex].weatherElement[12].time[index].elementValue[0].value!
            maxTemp.append(maxT + "º")
        }else if condition == "MinT"{
            var minT: String = ""
            minT = self.ViewModel.oneweeklocations[0].location[zoneIndex].weatherElement[8].time[index].elementValue[0].value!
            minTemp.append(minT + "º")
        }
    }
    
    func getWeatherImage(weather: String) -> String{
        var weatherText: String = ""
        
        if weather.contains("晴時多雲") {
            weatherText = "晴時多雲"
        }else if weather.contains("多雲時晴") {
            weatherText = "多雲時晴"
        }else if weather.contains("陰") && weather.contains("雨") {
            weatherText = "雨"
        }else if weather.contains("雨") {
            weatherText = "雨"
        }else if weather.contains("多雲") {
            weatherText = "多雲"
        }else if weather.contains("晴") {
            weatherText = "晴"
        }else if weather.contains("陰") {
            weatherText = "陰"
        }else if weather.contains("雷") {
            weatherText = "雷"
        }else if weather.contains("霧") {
            weatherText = "霧"
        }
    
        switch weatherText {
        case "晴":
            homeBackgroundImage.image = UIImage(named: "mainback_sun")
            return "city_weather_icon_sun"
        case "晴時多雲":
            homeBackgroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy_sun"
        case "多雲":
            homeBackgroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy"
        case "多雲時晴":
            homeBackgroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_cloudy_sun"
        case "雨":
            homeBackgroundImage.image = UIImage(named: "mainback_rain")
            return "city_weather_icon_rain"
        case "陰":
            homeBackgroundImage.image = UIImage(named: "mainback_cloudy")
            return "city_weather_icon_cloud"
        case "雷":
            homeBackgroundImage.image = UIImage(named: "mainback_cloudy")
            return "city_weather_icon_lightning_rain"
        case "霧":
            homeBackgroundImage.image = UIImage(named: "mainback_cloud")
            return "city_weather_icon_mist_sun"
        default:
            homeBackgroundImage.image = UIImage(named: "mainback_sun")
            return "city_weather_icon_sun"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weekNum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell

        cell.week.text = weekNum[indexPath.row]
        cell.weatherImage.image = UIImage(named: weatherImage[indexPath.row])
        cell.maxTemp.text = maxTemp[indexPath.row]
        cell.minTemp.text = minTemp[indexPath.row]

        cell.TextSetup()
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: fullScreenSize.width/7 - 5 , height: fullScreenSize.height/2)
    }
}
