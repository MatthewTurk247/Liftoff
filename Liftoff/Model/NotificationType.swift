//
//  NotificationType.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UserNotifications

protocol NotificationType {
    func makeNotificationRequest() -> UNNotificationRequest
}
