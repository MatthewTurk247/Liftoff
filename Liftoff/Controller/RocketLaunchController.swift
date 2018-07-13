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
        do {
            if !launch.rocket.imageURL.absoluteString.contains("placeholder") {
                rocketImage.image = UIImage(data: try Data(contentsOf: launch.rocket.imageURL))
            }
        } catch {
            print("error doing image stuff")
        }
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
    
    @objc func shareApp() {
        print("share")
        
        var firstActivityItem = "Download Liftoff by MonitorMOJO on the App Store today to learn about \(self.title!)!\n"
        
        if let launch = self.launch {
            if let vid = launch.videoURLs.first {
                firstActivityItem.append("Livestream: \(vid)")
            }
        }
        
        let secondActivityItem = NSURL(string: "https://itunes.apple.com/us/app/liftoff-track-rocket-launches/id1407517047")! // update this when there's actually a link
        // If you want to put an image
        //        let image : UIImage = UIImage(named: "image.jpg")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = self.navigationItem.rightBarButtonItem?.customView
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = .down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            .postToVimeo,
            UIActivityType.postToWeibo,
            .print,
            .saveToCameraRoll,
        ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
        self.navigationController?.navigationBar.setBackgroundImage(UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default), for:UIBarMetrics.default)
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.y / 150 // fixes it from being slightly colored at the beginning
        
        let updateNavColor = UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: offset)
        
        if offset > 1 {
            offset = 1
            //Update Navigation Item Color
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.navigationBar.isTranslucent = false
            
        } else {
            
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.tintColor = .white
            
        }
        
        //Update NavigationBar Background Color
        //self.navigationController?.navigationBar.backgroundColor = updateNavColor
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: offset)), for:UIBarMetrics.default)
    }
    
}

