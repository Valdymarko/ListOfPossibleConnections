//
//  AppDelegate.swift
//  ListOfPossibleConnections
//
//  Created by Володимир Ільків on 2/14/19.
//  Copyright © 2019 Володимр Ільків. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    public var btDataModel = BTDataModel.sharedInstance

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        btDataModel.stopScan()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        btDataModel.scanForAvailableDevices()
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}
