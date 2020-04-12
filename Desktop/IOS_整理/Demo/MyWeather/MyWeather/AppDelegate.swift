//
//  AppDelegate.swift
//  MyWeather
//
//  Created by Lung on 2019/9/9.
//  Copyright © 2019 Team. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
//        self.SplashScreen()
        
//        print("application第一次進入app時出現")
            
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
//        print("applicationWillResignActive當app浮起來準備進入背景時出現")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        print("applicationDidEnterBackground程式已經完全進入背景時出現")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
//        print("applicationWillEnterForeground當程式由背景狀態重新回到app前景時出現")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
//        print("applicationDidBecomeActive剛開啟app時出現")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
//        print("applicationWillTerminate將程式完全關閉結束時出現")
    }
    
    // LaunchScreen
    private func SplashScreen(){
        if (ConfirmNetworkConnection.isConnectedToNetwork()){
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(dismissSplashControll), userInfo: nil, repeats: false)
        }else{
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "關閉", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
//            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func dismissSplashControll(){
        let mainVC = UIStoryboard.init(name: "Main", bundle: nil)
        let rootVC = mainVC.instantiateViewController(withIdentifier: "initController")
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
}

