//
//  Notifications.swift
//  Liftoff
//
//  Created by Matthew Turk on 6/12/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import NotificationCenter
import UserNotifications
import DLLocalNotifications

struct NotificationManager {
    /*func checkNotificationEligibility() {
        let current = UNUserNotificationCenter.current()
        
        current.getNotificationSettings(completionHandler: { (settings) in
            if settings.authorizationStatus == .notDetermined {
                // Notification permission has not been asked yet, go for it!
                self.showLaunchNotifications.isEnabled = false
                self.showNewsNotifications.isEnabled = false
                self.showFactNotifications.isEnabled = false
                //self.enableNotificationsButton.setTitle("Enable Notifications", for: .highlighted)
                //self.enableNotificationsButton.setTitle("Enable Notifications", for: .normal)
            }
            
            if settings.authorizationStatus == .denied {
                // Notification permission was previously denied, go to settings & privacy to re-enable
                self.showLaunchNotifications.isEnabled = false
                self.showNewsNotifications.isEnabled = false
                self.showFactNotifications.isEnabled = false
                //self.enableNotificationsButton.setTitle("Enable Notifications", for: .highlighted)
                //self.enableNotificationsButton.setTitle("Enable Notifications", for: .normal)
            }
            
            if settings.authorizationStatus == .authorized {
                // Notification permission was already granted
                self.showLaunchNotifications.isEnabled = true
                self.showNewsNotifications.isEnabled = true
                self.showFactNotifications.isEnabled = true
                //self.enableNotificationsButton.setTitle("Disable Notifications", for: .highlighted)
                //self.enableNotificationsButton.setTitle("Disable Notifications", for: .normal)
            }
        })
    }*/
    
    let defaults = UserDefaults.standard
    let t = RepeatingTimer(timeInterval: 86399)
    
    func repeatNotification() {
        var factbook = Fact().factbook
        t.eventHandler = {
            factbook.shuffle()
            print(factbook)
        }
        t.resume()
        let calendar = Calendar.current
        var dateComponents = DateComponents()
                // a more realistic example for Gregorian calendar. Every Monday at 11:30AM
        dateComponents.hour = 9
        dateComponents.minute = 30

        let theTime = calendar.date(from: dateComponents)
        
        let firstNotification = DLNotification(identifier: "fact.of.the.day", alertTitle: "Did You Know?", alertBody: factbook[Int(arc4random_uniform(UInt32(factbook.count)) + 1) - 1], date: theTime, repeats: .Daily)
        
        let scheduler = DLNotificationScheduler()
        scheduler.scheduleNotification(notification: firstNotification)
        defaults.set(true, forKey: "allowDailyFact")
    }
    
    func stopNotification() {
        defaults.set(false, forKey: "allowDailyFact")
        DLNotificationScheduler().cancelAlllNotifications()
        t.suspend()
    }
}
