//
//  WebViewController.swift
//  MyWeather
//
//  Created by Lung on 2019/12/2.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class WebViewController: UIViewController {

    var myWebView: WKWebView!
    var observationText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrl = observationURL(observationText)
        
        loadUrl(myUrl)
    }
}
extension WebViewController: WKNavigationDelegate{
    
    func observationURL(_ observationText: String) -> String {
        var observationURL: String = ""
        
        switch observationText {
        case "雷達回波":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Radar.html"
            return observationURL
        case "衛星雲圖":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Sat.html"
            return observationURL
        case "累積雨量圖":
            observationURL = "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_QZJ.html"
            return observationURL
        case "溫度分布圖":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Temp.html"
            return observationURL
        case "紫外線測報":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_UVI.html"
            return observationURL
        case "即時閃電":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Lightning.html"
            return observationURL
        case "今日排行榜":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Top.html"
            return observationURL
        case "前100大雨量":
            observationURL = "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_Top100.html"
            return observationURL
        case "縣市最大雨量":
            observationURL = "https://www.cwb.gov.tw/V8/C/P/Rainfall/Rainfall_CountyMax.html"
            return observationURL
        case "前100名溫度資料":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/OBS_Top100.html"
            return observationURL
        case "縣市溫度極值資料":
            observationURL = "https://www.cwb.gov.tw/V8/C/W/County_TempTop.html"
            return observationURL
        default:
            return ""
        }
    }
    
    func loadUrl(_ strUrl: String){
        let Url = URL(string: strUrl)
        
        if let url = Url {
            let myRequest = URLRequest(url: url)
            
            myWebView = WKWebView(frame: self.view.frame)
            
            if let WebView = myWebView {
                WebView.navigationDelegate = self
                WebView.load(myRequest)
                
                self.view.addSubview(WebView)
                self.view.sendSubviewToBack(WebView)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.getElementById(\"header\").style.display='none';document.getElementById(\"footer-v3\").style.display='none';document.getElementById('normal').getElementsByClassName('other')[0].style.display = 'none';document.getElementById(\"normal\").getElementsByClassName(\"btn-blue\")[0].style.display='none';") { (result, error) in
            if error == nil {
                
            }
        }
    }
}
