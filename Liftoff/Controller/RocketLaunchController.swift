//
//  RocketLaunchController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import CountdownLabel

protocol RocketLaunchControllerDelegate: class {
    func savedButtonPressed(launch: RocketLaunch) -> ()
}

class RocketLaunchController: UITableViewController, MKMapViewDelegate {
    
    @IBOutlet var descTextView: UITextView!
    @IBOutlet var rocketImage: UIImageView!
    @IBOutlet var countdownLabel: CountdownLabel!
    @IBOutlet var rocketNameLabel: UILabel!
    @IBOutlet var launchMap: MKMapView!
    
    var launch: Launch?
    let textProvider = LaunchTextProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Rocket data
        if let launch = launch {
            configure(withLaunch: launch)
            print("hello")
            print(launch.location.pads[0].coordinate.latitude, launch.location.pads[0].coordinate.longitude)
        }

    
    }
    
    private func configure(withLaunch launch: Launch) {
        title = launch.rocket.name
        descTextView.text = launch.missions.first?.description
        descTextView.translatesAutoresizingMaskIntoConstraints = true
        descTextView.sizeToFit()
        descTextView.isScrollEnabled = false
        countdownLabel.text = textProvider.countdownString(from: launch.windowOpenDate)
        rocketNameLabel.text = "Rocket: \(launch.rocket.name)\nAgency: \(launch.rocket.agencies.first!.name)"
        let spot = launch.location.pads.first!.coordinate
        self.launchMap.setCenter(spot, animated: false)
        let span = MKCoordinateSpanMake(0.8, 0.8)
        let region = MKCoordinateRegion(center: spot, span: span)
        self.launchMap.setRegion(region, animated: false)
        var annotation = MKPointAnnotation()
        annotation.coordinate = spot
        annotation.title = launch.location.name
        annotation.subtitle = launch.location.countryCode
        self.launchMap.addAnnotation(annotation)
        self.tableView.reloadData()
        
    }
    
}

