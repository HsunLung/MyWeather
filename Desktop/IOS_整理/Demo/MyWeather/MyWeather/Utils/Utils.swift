//
//  Utils.swift
//  MyWeather
//
//  Created by Lung on 2019/11/22.
//  Copyright © 2019 Team. All rights reserved.
//

import Foundation
import UIKit
import Network
import SystemConfiguration

/* 系統底層 URL
 電池電量 Prefs:root=BATTERY_USAGE
 通用設置 Prefs:root=General
 存儲空間 Prefs:root=General&path=STORAGE_ICLOUD_USAGE/DEVICE_STORAGE
 蜂窩數據 Prefs:root=MOBILE_DATA_SETTINGS_ID
 Wi-Fi 設置 Prefs:root=WIFI
 藍牙設置 Prefs:root=Bluetooth
 定位設置 Prefs:root=Privacy&path=LOCATION
 輔助功能 Prefs:root=General&path=ACCESSIBILITY
 關於手機 Prefs:root=General&path=About
 鍵盤設置 Prefs:root=General&path=Keyboard
 顯示設置 Prefs:root=DISPLAY
 聲音設置 Prefs:root=Sounds
 App Store 設置 Prefs:root=STORE
 牆紙設置 Prefs:root=Wallpaper
 打開電話 Mobilephone://
 世界時鐘 Clock-worldclock://
 鬧鐘 Clock-alarm://
 秒錶 Clock-stopwatch://
 倒計時 Clock-timer://
 打開相冊 Photos://
 */

// 機型判斷
public class IphoneModel {

    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
//        print(identifier)
        
//        iPhone10,3 : iPhone X Global
//        iPhone10,6 : iPhone X GSM
//        iPhone11,2 : iPhone XS
//        iPhone11,4 : iPhone XS Max
//        iPhone11,6 : iPhone XS Max Global
//        iPhone11,8 : iPhone XR
//        iPhone12,1 : iPhone 11
//        iPhone12,3 : iPhone 11 Pro
//        iPhone12,5 : iPhone 11 Pro Max
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
//        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
//        case "i386", "x86_64":                          return "Simulator"
        default:                                        return "identifier"
        }
    }
}

// 網路判斷
public class NetworkJudgment {
    static let shared = NetworkJudgment()

    var monitor: NWPathMonitor?

    var isMonitoring = false

    // 開始監控網路
    var didStartMonitoringHandler: (() -> Void)?

    // 停止監控網路
    var didStopMonitoringHandler: (() -> Void)?

    // 網路狀態出現變更
    var netStatusChangeHandler: (() -> Void)?

    // 判斷裝置是否連線
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }

    // 取得現在的網路介面類型
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil}
        return monitor.currentPath.availableInterfaces.filter { monitor.currentPath.usesInterfaceType($0.type)}.first?.type
    }

    // 取得可用介面類型
    var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }

    // 確認昂貴的網路介面 特定的網路介面 (像是行動網路)
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }

    // MARK: - Init & Deinit
    private init() {

    }

    deinit {
        stopMonitoring()
    }

    func startMonitoring() {
        guard !isMonitoring else { return }

        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)

        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }

        isMonitoring = true
        didStartMonitoringHandler?()
    }

    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }

        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
}

// 基本的網路偵測
public class ConfirmNetworkConnection {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
}
