//
//  WeatherService.swift
//  MyWeather
//
//  Created by Lung on 2019/9/12.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel {
    // Weather Json （網址）
    var UrlApi = API()
    // 36小時天氣預報 資料
    var reloadWeather = {() -> () in}
    var errorMessage = {(message: String) -> () in}
    
    var location: [WeatherModel.Location] = [] {
        didSet{
            reloadWeather()
        }
    }
    // 36小時天氣預報API
    func getWeatherData() {
        guard let Url = URL(string: UrlApi.WeatherAPI) else {return}
        
        URLSession.shared.dataTask(with: Url){ (data, response, error) in
            guard let weatherData = data else {return}
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(WeatherModel.self, from: weatherData)
                
//                self.location = json.records.location
                
                for var i in 0...21 {
                    i -= 1
                    json.records.location.forEach { list in
                        let Num: Int = self.citySort(locationName: list.locationName!)
                        if Num == self.location.count {
                            self.location.append(list)
                            i += 1
                        }
                    }
                }
                
                print(self.location)
            }catch let error{
                print("Error -> \(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    
    func citySort(locationName: String) -> Int {
        var cityNum: Int = 0
        
        switch locationName {
        case "基隆市":
            cityNum = 0
        case "臺北市":
            cityNum = 1
        case "新北市":
            cityNum = 2
        case "桃園市":
            cityNum = 3
        case "新竹市":
            cityNum = 4
        case "新竹縣":
            cityNum = 5
        case "苗栗縣":
            cityNum = 6
        case "臺中市":
            cityNum = 7
        case "彰化縣":
            cityNum = 8
        case "南投縣":
            cityNum = 9
        case "雲林縣":
            cityNum = 10
        case "嘉義市":
            cityNum = 11
        case "嘉義縣":
            cityNum = 12
        case "臺南市":
            cityNum = 13
        case "高雄市":
            cityNum = 14
        case "屏東縣":
            cityNum = 15
        case "臺東縣":
            cityNum = 16
        case "花蓮縣":
            cityNum = 17
        case "宜蘭縣":
            cityNum = 18
        case "澎湖縣":
            cityNum = 19
        case "金門縣":
            cityNum = 20
        case "連江縣":
            cityNum = 21
        default:
            cityNum = 22
        }
        
        return cityNum
    }

//    func weatherDownload(WeatherTableView: UITableView) {
//        if let url = URL(string: UrlApi.WeatherAPI){
//            let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
//                do {
//                    // 創建一個 JSONDecoder 實例來解析我們的 data
//                    // 若解析成功則會將其轉換成我們所定義的 Decodable 的結構。
//                    let decoder = JSONDecoder()
//                    // 解析json 編碼
//                    decoder.dateDecodingStrategy = .iso8601
//                    let json = try decoder.decode(WeatherModel.self, from: data!)
//                    //print(json)
//
//                    self.location = json.records.location
//
//                    DispatchQueue.main.async {
//                        WeatherTableView.reloadData()
//                    }
//
//                    // TODO: 獲取 Bookshelf 資料後的操作
//                } catch {
//                    // 若格式錯誤則會印出下列錯誤訊息。
//                    /* The data couldn’t be read because it isn’t in the correct format. */
//                    print("weather error: " + error.localizedDescription)
//                }
//            }
//            task.resume()
//        }
//    }
}
