//
//  UrlPath.swift
//  MyWeather
//
//  Created by Lung on 2019/9/9.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation

class API {
    /// 36 小時天氣預報
    var WeatherAPI: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（基隆市）
    var KeelungCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-051?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（澎湖縣）
    var WuhuCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-047?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（花蓮縣）
    var HualienCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-043?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（臺東縣）
    var TaitungCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-039?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（臺南市）
    var TainanCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-079?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（新竹市）
    var HsinchuCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-055?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（臺北市）
    var TaipeiCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-063?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（新北市）
    var NewTaipeiCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-071?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（臺中市）
    var TaichungCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-075?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（連江縣）
    var LianjiangCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-083?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（金門縣）
    var JinmenCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-087?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（高雄市)
    var KaohsiungCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-067?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（屏東縣）
    var PingtungCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-035?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（桃園市）
    var TaoyuanCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-007?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（新竹縣）
    var HsinchuCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-011?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（嘉義市）
    var ChiayiCity_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-059?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（嘉義縣）
    var ChiayiCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-031?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（雲林縣）
    var YunlinCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-027?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（南投縣）
    var NantouCounty_API: String =    "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-023?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（彰化縣）
    var ChanghuaCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-019?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（苗栗縣）
    var MiaoliCounty_API: String = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-015?Authorization=rdec-key-123-45678-011121314"
    ///  一週天氣預報（宜蘭縣）
    var YilanCounty_API: String =  "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-003?Authorization=rdec-key-123-45678-011121314"
    
    func getCounty_API(_ county: String) -> String {
        switch county {
        case "基隆市":
            return KeelungCity_API
        case "臺北市":
            return TaipeiCity_API
        case "新北市":
            return NewTaipeiCity_API
        case "桃園市":
            return TaoyuanCity_API
        case "新竹市":
            return HsinchuCity_API
        case "新竹縣":
            return HsinchuCounty_API
        case "苗栗縣":
            return MiaoliCounty_API
        case "臺中市":
            return TaichungCity_API
        case "彰化縣":
            return ChanghuaCounty_API
        case "南投縣":
            return NantouCounty_API
        case "雲林縣":
            return YunlinCounty_API
        case "嘉義市":
            return ChiayiCity_API
        case "嘉義縣":
            return ChiayiCounty_API
        case "臺南市":
            return TainanCity_API
        case "高雄市":
            return KaohsiungCity_API
        case "屏東縣":
            return PingtungCounty_API
        case "臺東縣":
            return TaitungCounty_API
        case "花蓮縣":
            return HualienCounty_API
        case "宜蘭縣":
            return YilanCounty_API
        case "澎湖縣":
            return WuhuCounty_API
        case "金門縣":
            return JinmenCounty_API
        case "連江縣":
            return LianjiangCounty_API
        default:
            return TaipeiCity_API
        }
    }
}
