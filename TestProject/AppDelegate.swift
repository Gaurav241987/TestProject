//
//  AppDelegate.swift
//  TestProject
//
//  Created by Gaurav on 25/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

var iPhoneX_TopPadding:CGFloat = UIApplication.shared.statusBarFrame.height;
var iPhoneX_BottomPadding:CGFloat = UIApplication.shared.statusBarFrame.height;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let IS_IPHONE_X_XPLUS_XR  = UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
    
        if #available(iOS 11.0, *) {
            
            if (IS_IPHONE_X_XPLUS_XR) {
                
                iPhoneX_TopPadding = iPhoneX_TopPadding + (self.window?.safeAreaInsets.top)!
                iPhoneX_BottomPadding = iPhoneX_BottomPadding + (self.window?.safeAreaInsets.bottom)!;

            } else {
                // Fallback on earlier versions
            };
        }
       
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

