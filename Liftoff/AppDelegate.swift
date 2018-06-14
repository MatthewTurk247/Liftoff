//
//  AppDelegate.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/7/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            let defaults = UserDefaults.standard
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {didSucceed, error in
                    if error == nil {
                        print("Successfully got the notifications")
                        if didSucceed {
                            defaults.setValue(true, forKey: "allowNotifications")
                            NotificationManager().repeatNotification()
                        } else {
                            defaults.setValue(false, forKey: "allowNotifications")
                            NotificationManager().stopNotification()
                        }
                    } else {
                        defaults.setValue(false, forKey: "allowNotifications")
                        NotificationManager().stopNotification()
                    }
            })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
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
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
        let shouldWithhold = UserDefaults.standard.value(forKey: "allowNotifications")
        // There must be a way to withhold notifications depending on the user default above.
    }
    
}

