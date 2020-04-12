//
//  WeatherModel.swift
//  MyWeather
//
//  Created by Lung on 2019/9/9.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation

// 36 小時天氣預報 Model
struct WeatherModel: Decodable {
    /**
     * success : true
     * result : Result
     * records : Records
     */
    var success: String?
    var result: Result
    var records: Records

    struct Result: Decodable {
        /**
         * resource_id : F-C0032-001
         * fields : [{"id":"datasetDescription","type":"String"},{"id":"locationName","type":"String"},
         * {"id":"parameterName","type":"String"},{"id":"parameterValue","type":"String"},
         * {"id":"parameterUnit","type":"String"},{"id":"startTime","type":"Timestamp"},
         * {"id":"endTime","type":"Timestamp"}]
         */
        var resource_id: String?
        var fields: [Fields]
    }

    struct Fields: Decodable {
        /**
         * id : datasetDescription
         * type : String
         */
        var id: String?
        var type: String?
    }

    struct Records: Decodable {
        /**
         * datasetDescription : 三十六小時天氣預報
         * location : [Location]
         */
        var datasetDescription: String?
        var location: [Location]
    }

    struct Location: Decodable {
        /**
         * locationName : 嘉義縣
         * weatherElement : [WeatherElement]
         */
        var locationName: String?
        var weatherElement: [WeatherElement]
    }

    struct WeatherElement: Decodable {
        /**
         * elementName : Wx
         * time : [Time]
         */
        var elementName: String?
        var time: [Time]
    }

    struct Time: Decodable {
        /**
         * startTime : 2019-09-26 18:00:00
         * endTime : 2019-09-27 06:00:00
         * parameter : Parameter
         */
        var startTime: String?
        var endTime: String?
        var parameter: Parameter
    }

    struct Parameter: Decodable {
        /**
         * parameterName : 多雲時晴
         * parameterValue : 3
         */
        var parameterName: String?
        var parameterValue: String?
        var parameterUnit: String?
    }
}

// 一週天氣預報（高雄市） Model
struct OneWeekWeatherModel: Decodable {
    /**
     * success : true
     * result : Result
     * records : Records
     */
    var success: String?
    var result: Result
    var records: Records
    
    struct Result: Decodable {
        /**
         * resource_id : F-D0047-067
         * fields : [{"id":"contentDescription","type":"String"},{"id":"datasetDescription","type":"String"},
         * {"id":"locationsName","type":"String"},{"id":"dataid","type":"String"},
         * {"id":"locationName","type":"String"},{"id":"geocode","type":"Double"},
         * {"id":"lat","type":"Double"},{"id":"lon","type":"Double"},
         * {"id":"elementName","type":"String"},{"id":"description","type":"String"},
         * {"id":"startTime","type":"Timestamp"},{"id":"endTime","type":"Timestamp"},
         * {"id":"dataTime","type":"Timestamp"},{"id":"value","type":"String"},{"id":"measures","type":"String"}]
         */
        var resource_id: String?
        var fields: [Fields]
    }
    
    struct Fields: Decodable {
        /**
         * id : contentDescription
         * type : String
         */
        var id: String?
        var type: String?
    }
    
    struct Records: Decodable {
        var locations: [Locations]
    }
    
    struct Locations: Decodable {
        /**
         * datasetDescription : 臺灣各縣市鄉鎮未來1週逐12小時天氣預報
         * locationsName : 高雄市
         * dataid : D0047-067
         * location :[Location]
         */
        var datasetDescription: String?
        var locationsName: String?
        var dataid: String?
        var location: [Location]
    }
    
    struct Location: Decodable {
        /**
         * locationName : 新興區
         * geocode : 6400600
         * lat : 22.63276
         * lon : 120.301947
         * weatherElement :[WeatherElement]
         */
        var locationName: String?
        var geocode: String?
        var lat: String?
        var lon: String?
        var weatherElement: [WeatherElement]
    }
    
    struct WeatherElement: Decodable {
        /**
         * elementName : PoP12h
         * description : 12小時降雨機率
         * time :[Time]
         */

        var elementName: String?
        var description: String?
        var time: [Time]
    }
    
    struct Time: Decodable {
        /**
         * startTime : 2019-09-26 00:00:00
         * endTime : 2019-09-26 06:00:00
         * elementValue : [ElementValue]
         */
        var startTime: String?
        var endTime: String?
        var elementValue: [ElementValue]
    }
    
    struct ElementValue: Decodable {
        /**
         * value : 0
         * measures : 百分比
         */
        var value: String?
        var measures: String?
    }
}
