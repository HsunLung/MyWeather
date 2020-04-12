//
//  FirstController.swift
//  MyWeather
//
//  Created by Lung on 2019/11/30.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

class FirstController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    
    var timer = Timer()
    
    var nowVersion = ""
    let thisVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    var versionSession = URLSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageSetup()
        NotificationCenter.default.addObserver(self, selector: #selector(checkStatus), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkStatus()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
}
extension FirstController {
    
    func imageSetup() {
        self.view.backgroundColor = .black
        firstImageView.image = UIImage(named: "launchscreen")
        firstImageView.contentMode = .scaleToFill
    }
    
    @objc func checkStatus() {
        if !ConfirmNetworkConnection.isConnectedToNetwork() {
            let alertController = UIAlertController(title: "請開啟網路連線或使用Wifi連線", message: nil, preferredStyle: .alert)
            let closeAction = UIAlertAction(title: "關閉", style: .default, handler: nil)
            let settingAction = UIAlertAction(title: "設定", style: .default, handler: { action in
                // 跳至網路設定
//                let network = URL(string: UIApplication.openSettingsURLString)
                let network = URL(string: "App-Prefs:root=General")
                
                if UIApplication.shared.canOpenURL(network!) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(network!)
                    } else {
                        UIApplication.shared.openURL(network!)
                    }
                }
            })
            
            alertController.addAction(closeAction)
            alertController.addAction(settingAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
//            getVersion()
//
//            if thisVersion != nowVersion {
//                checkVersion()
//            } else {
//                self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(disMiss), userInfo: nil, repeats: true)
//            }
            
            self.timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(disMiss), userInfo: nil, repeats: true)
        }
    }
    
    @objc func disMiss() {
        timer.invalidate()
        
        // 呈現主畫面
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "initController") {
            UIApplication.shared.keyWindow?.rootViewController = vc
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // get vision
    @objc func getVersion() {
        let urlStr = ""
        let url = URL(string: urlStr)
        var request: URLRequest = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.httpMethod = "POST"
        let config = URLSessionConfiguration.default
        versionSession = URLSession(configuration: config, delegate: self, delegateQueue: OperationQueue.main)
        _ = versionSession.downloadTask(with: request).resume()
    }
    
    @objc func checkVersion() {
        if thisVersion != nowVersion {
            let alertController = UIAlertController(title: "訊息", message: "您的看看天氣並未更新到最新版，請更新至最新版本", preferredStyle: .alert)
            let updateAction = UIAlertAction(title: "確認", style: .default, handler: { action in
                UIApplication.shared.openURL(URL(string: "https://apps.apple.com/tw/app/%E7%9C%8B%E7%9C%8B%E5%A4%A9%E6%B0%A3/id1488575551")!)
            })
            
            alertController.addAction(updateAction)
            
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                vc.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
extension FirstController: URLSessionDelegate, URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let postData = NSData(contentsOf: location)
        
        do{
            DispatchQueue.main.async {
                // do something here
            }
            
            if session == versionSession {
                let array = try JSONSerialization.jsonObject(with: Data(contentsOf: location), options: .mutableContainers) as! NSDictionary
                let dataArray = array.object(forKey: "results") as! NSArray
                let data = dataArray[0] as! NSDictionary
                nowVersion = "\(String(describing: data.object(forKey: "version")!))"
                print(nowVersion)
                checkVersion()
            }
        } catch {
            // do something
        }
        
        session.finishTasksAndInvalidate()
    }
}
