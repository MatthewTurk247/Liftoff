//
//  MissionsDetailViewController.swift
//  Rockety
//
//  Created by Antoine Bellanger on 22.05.18.
//  Copyright © 2018 Antoine Bellanger. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class MissionsDetailViewController: UITableViewController {
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    @IBOutlet weak var launchTextView: UITextView!
    @IBOutlet weak var rocketTextView: UITextView!
    @IBOutlet weak var launchMapView: MKMapView!
    var isSpaceX: Bool!
    var downloaded = false
    var isComingFromAgency = false
    
    var mission: Mission? {
        didSet {
            configureView()
        }
    }
    var rocket: Rocket? {
        didSet {
            configureView()
        }
    }
    var launchpad: Launchpad?
    
    var launch: ElseMission.Launch? {
        didSet {
            configureView()
        }
    }
    var rocketAPI: API.Rocket = .rocket999
    
    var missionPayloadType: Payloads = .notAvailable
    
    func configureView() {
        // Update the user interface for the detail item.
        if let launch = launch {
            if let mission = launch.missions.first {
                if let textView = launchTextView {
                    textView.text = String(mission.description)
                }
            }
        } else if let mission = mission {
            title = mission.mission_name
        }
        
        if let launchpad = launchpad {
            launchMapView.centerToLocation(CLLocation(latitude: launchpad.location.latitude, longitude: launchpad.location.longitude))
        }
        
        if let rocket = rocket {
            print(rocket.description)
            if let textView = rocketTextView {
                textView.text = rocket.description
            }
        }
    }
    
    override func viewDidLoad() {
        configureView()
    }
    
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
