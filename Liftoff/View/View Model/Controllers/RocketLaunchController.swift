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
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var launchMap: MKMapView!
    
    var launch: RocketLaunch!
    var launchSaved: Bool!
    var isMapable = true
    
    weak var delegate: RocketLaunchControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Load Rocket data
        guard let launchToDisplay = launch, let rocket = launchToDisplay.rocket else { return }
        loadUIElements(rocket: rocket)
        // Toggle 'Save' button
        guard let unwrappedBool = launchSaved else { return }
        if unwrappedBool { toggleSaveButton() }
        self.tableView.contentInset = UIEdgeInsetsMake(-88,0,0,0);
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = String(describing: launchToDisplay.date!.dropLast(13))
        print("dateString", dateString)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let target = dateFormatter.date(from: dateString) as! NSDate
        countdownLabel.text = dateString
        //countdownLabel.setCountDownDate(targetDate: target)
        //countdownLabel.setCountDownTime(minutes: 3600)
        //countdownLabel.start()
        // Sad face... :(
        
        if let launchLocation = launch.launchFrom {
            print("Place: \(launchLocation)")
            CLGeocoder().geocodeAddressString(launchLocation) { (placemarks, err) in
                if placemarks != nil {
                    self.launchMap.setCenter(placemarks![0].location!.coordinate, animated: false)
                    let span = MKCoordinateSpanMake(0.8, 0.8)
                    let region = MKCoordinateRegion(center: placemarks![0].location!.coordinate, span: span)
                    self.launchMap.setRegion(region, animated: false)
                    var annotation = MKPointAnnotation()
                    annotation.coordinate = (placemarks![0].location?.coordinate)!
                    if let n = self.launch.name {
                        annotation.title = n
                    }
                    annotation.subtitle = launchLocation
                    self.launchMap.addAnnotation(annotation)
                    print(placemarks![0].location?.coordinate.latitude, placemarks![0].location?.coordinate.longitude)
                    self.isMapable = true
                    self.tableView.reloadData()
                } else {
                    print(err)
                    self.isMapable = false
                    self.tableView.reloadData()
                }
            }
        }
        
        // TODO: Add countdown timer label
    }
    
    @objc func shareApp() {
        print("share")
        let firstActivityItem = "Download Liftoff by MonitorMOJO on the App Store today to learn about \(self.title!)!\n"
        let secondActivityItem : NSURL = NSURL(string: "https://itunes.apple.com/us/developer/monitormojo-inc/id1370996012")! // update this when there's actually a link
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isMapable {
            return 3
        } else {
            return 2
        }
    }
    
    func loadUIElements(rocket: Rocket) {
        // Display properties of the rocket
        self.title = rocket.name
        descTextView.text = launch.missionDesc
        rocketNameLabel.text = "Rocket Name: \(rocket.name!)"
        if let agencies = rocket.agencies {
            for agency in agencies {
                if let name = agency["name"] as? String {
                    //rocketNameLabel.text = rocketNameLabel.text! + "\nAgencies Involved: \(rocketNameLabel.text!)\(name)"
                    print("AGENCY: \(name)")
                    rocketNameLabel.text = (rocketNameLabel.text ?? "") + "\nAgencies Involved: \(name)"
                } else {
                    rocketNameLabel.text = "Unable to obtain information."
                }
            }
        }
        rocketImage.image = rocket.image
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        // Save to NSUserDefaults
        // TODO: No completion handler?
        if let delegate = delegate {
            delegate.savedButtonPressed(launch: launch)
            // Update UI
            toggleSaveButton()
        }
    }
    
    func toggleSaveButton() {
        // Update UIBarButtonItem
        saveButton.title = "Saved"
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
}

