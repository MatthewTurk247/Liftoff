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
    
    func repeatNotification() {
        let factbook = ["The largest star in the universe is being consumed by a black hole", "Since there is no medium for sound to travel, space will always be eerily silent", "Venus rotates slower than it orbits the sun, making a day outlast a year", "If two metals touch in space, they will bond through cold welding and be eternally stuck together", "NASA classifies stars by temperature and one from the coldest class is 20ºC", "Neutron stars implode so hard that all of their atoms melt together leaving only neutrons", "There's no wind on the moon, so astronaut footprints will be there forever.", "The sun's mass is 99% of the mass in the solar system", "The planet 55 Cancri-e is mostly made of diamond, worth $26.9 nonillion", "More energy from the sun hits Earth every hour than the planet uses in a year", "Due to the Drake Equation, there could be up to 140,000 intelligent civilizations in our galaxy", "Since gravity doesn't compress your spine in space, astronauts get taller when they leave earth", "If you held your breath unprotected in space, the loss of pressure would cause your lungs to expand and explode", "We've found over 1,500 exoplanets in the past 20 years", "Theoretically all the other planets in the solar system could fit between Earth and the moon.", "If you traveled at the speed of light, you would stop aging and you'd warp to the end of time", "If we ever found the end or repeat of an irrational number, the universe could be a computer simulation", "The reason why we only see one side of the moon is because of tidal locking", "Saturn's rings are made from billions of particles ranging from grains of sand to mountain-size chunks of ice", "In 2 billion years, the Milky Way and the nearst galaxy Andromeda will collide creating Milkdromeda", "We have discovered 5% of the universe", "Uranus has an east and west pole", "It takes our solar system 230 million years to rotate around the Milky Way", "Surface temperatures on Venus can rise past 800°F; the planet melts space probes", "The human race has existed for 1/31,536,000 of time", "NASA is currently working on the development of a warp drive that could get astronotus to Alpha Centauri in 2 weeks", "Mars has the biggest volcano (that we know of)"]
        let calendar = Calendar.current
        var dateComponents = DateComponents()
                // a more realistic example for Gregorian calendar. Every Monday at 11:30AM
        dateComponents.hour = 9
        dateComponents.minute = 30

        let theTime = calendar.date(from: dateComponents)
        
        let firstNotification = DLNotification(identifier: "fact.of.the.day", alertTitle: "Did You Know?", alertBody: factbook[Int(arc4random_uniform(UInt32(factbook.count)) + 1) - 1], date: theTime, repeats: .Hourly)
        
        let scheduler = DLNotificationScheduler()
        scheduler.scheduleNotification(notification: firstNotification)
        defaults.set(true, forKey: "allowDailyFact")
    }
    
    func stopNotification() {
        defaults.set(false, forKey: "allowDailyFact")
        DLNotificationScheduler().cancelAlllNotifications()
    }
}
