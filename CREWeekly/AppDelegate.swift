//
//  AppDelegate.swift
//  CREWeekly
//
//  Created by Feihong Zhao on 2017-08-19.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: MessagesCollectionViewController(collectionViewLayout: layout))
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        SocketIOManager.sharedInstance.establishConnection()
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        SocketIOManager.sharedInstance.closeConnection()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        SocketIOManager.sharedInstance.closeConnection()
    }
}

