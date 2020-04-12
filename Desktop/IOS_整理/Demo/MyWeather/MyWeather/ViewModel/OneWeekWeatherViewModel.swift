//
//  OneWeekWeatherViewModel.swift
//  MyWeather
//
//  Created by Lung on 2019/10/16.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation
import UIKit

class OneWeekWeatherViewModel {
    // Weather Json （網址）
    var CityApi = API()
    // 一週天氣預報資料
    var reloadOneWeekWeather = {() -> () in}
    var errorMessage = {(message: String) -> () in}
    
    var oneweeklocations: [OneWeekWeatherModel.Locations] = [] {
        didSet{
            reloadOneWeekWeather()
        }
    }
    
    // 一週天氣 API
    func getCounty(county: String){
        getOneWeekWeatherData(CityApi.getCounty_API(county))
    }
    
    // 一週天氣 Data
    func getOneWeekWeatherData(_ url: String) {
        guard let Url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: Url){ (data, response, error) in
            guard let weatherData = data else {return}
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(OneWeekWeatherModel.self, from: weatherData)
                
                self.oneweeklocations = json.records.locations
                
//                print(self.oneweeklocations)
            }catch let error{
                print("Error -> \(error.localizedDescription)")
                self.errorMessage(error.localizedDescription)
            }
        }.resume()
    }
    
//    func OneWeekWeatherDownload(homeCollectionView: UICollectionView){
//        if let url = URL(string: UrlApi.OneWeek_WeatherAPI){
//            let task = URLSession.shared.dataTask(with: url){(data, response, error) in
//                do{
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .iso8601
//                    let json = try decoder.decode(OneWeekWeatherModel.self, from: data!)
//                    //print(json)
//
//                    self.oneweeklocation = json.records.locations
////                    print(self.oneweeklocation[0].location[0].locationName)
//
//                    DispatchQueue.main.async {
//                        homeCollectionView.reloadData()
//                    }
//                }catch{
//                    print("oneweekweather error: " + error.localizedDescription)
//                }
//            }
//            task.resume()
//        }
//    }
}
