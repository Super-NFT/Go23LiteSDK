//
//  AppDelegate.swift
//  Go23LiteSDK
//
//  Created by ming.lu on 02/03/2023.
//  Copyright (c) 2023 ming.lu. All rights reserved.
//

import UIKit
import Go23LiteSDK
//import IQKeyboardManager
//import SDWebImageWebPCoder
import Go23SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Replace yout appKey and secretKey here.
        //release
        Go23WalletSDK.auth(appKey: "OcHB6Ix8bIWiOyE35ze6Ra9e",
                           secretKey: "KX6OquHkkKQmzLSncmnmNt2q") { result in
            if result {
                NotificationCenter.default.post(name: NSNotification.Name(kRegisterUser),
                                                object: nil,
                                                userInfo: nil)
            }
            print("Go23WalletSDK.auth === \(result)")
        }
        
        //debug
//        Go23WalletSDK.auth(appKey: "j9ASxn5REHG8akytevRYZwCp",
//                           secretKey: "QHXFT28Nu1u4R7IiGBlFCVXF") { result in
//            if result {
//                NotificationCenter.default.post(name: NSNotification.Name(kRegisterUser),
//                                                object: nil,
//                                                userInfo: nil)
//            }
//            print("Go23WalletSDK.auth === \(result)")
//        }
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let vc = Go23HomeViewController()
        vc.view.backgroundColor = .white
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

