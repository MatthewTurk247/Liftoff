//
//  LaunchCell.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

class LaunchCell: UITableViewCell {
    static var reuseID: String {
        return "LaunchCell"
    }
    
    @IBOutlet private var rocketLabel: UILabel!
    @IBOutlet private var missionLabel: UILabel!
    @IBOutlet var rocketNameLabel: UITextView!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet var launchSiteLabel: UILabel!
    @IBOutlet var previewImageView: UIImageView!
    
    private var timer: Timer?
    private let textProvider = LaunchTextProvider()
    
    func configure(with launch: Launch) {
//        if let m = launch.missions.first {
//            rocketLabel.text = m.name
//        } else {
         rocketLabel.text = launch.rocket.name
//        }
        missionLabel.text = "\(launch.rocket.agencies?.first?.name ?? "") \(launch.rocket.agencies?.first?.countryCode.flag() ?? "")"
        // probabilityLabel.text = textProvider.probabilityString(from: launch.probability)
        launchSiteLabel.text = launch.location.name
        rocketNameLabel.text = launch.rocket.name
        
//        let isHidden = (launch.rocket.agencies.first?.name ?? "").isEmpty
//        missionLabel.isHidden = isHidden
//        missionIconView.isHidden = isHidden
        
        configureTimeLabel(with: launch)
        scheduleTimerIfNecessary(for: launch)
        
        if !launch.rocket.imageURL.contains("placeholder") {
            previewImageView.loadUsingCache(launch.rocket.imageURL)
        }
        
    }
    
    // MARK: Private
    
    private func scheduleTimerIfNecessary(for launch: Launch) {
//        let timeUntil = launch.windowOpenDate.timeIntervalSinceNow
//        if timeUntil < .oneDay * 2 {
//            timer = Timer(timeInterval: 0.25, repeats: true) { [weak self] _ in
//                self?.configureTimeLabel(with: launch)
//            }
//            RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
//        } else {
//            timer?.invalidate()
//            timer = nil
//        }
    }
    
    private func configureTimeLabel(with launch: Launch) {
//        timeLabel.text = textProvider.countdownString(from: launch.windowOpenDate)
//        timeLabel.textColor = launch.status == Launch.Status.green || launch.status == Launch.Status.success ? UIColor(red: 0, green: 184/255, blue: 148/255, alpha: 1) : (launch.status == Launch.Status.unknown ? UIColor(red: 92/255, green: 94/255, blue: 102/255, alpha: 1) : UIColor(red: 214/255, green: 48/255, blue: 49/255, alpha: 1))
    }
}
