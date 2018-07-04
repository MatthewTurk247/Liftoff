//
//  RocketLaunchesController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

protocol RocketLaunchesControllerDelegate {
    func isWaitingForData(_ isLoading: Bool) -> ()
}

class RocketLaunchesController: UITableViewController {
    
    // Connect to Model: Must Have
    var viewModel: RocketLaunchesModel!
    
    //To check Internet connection
    var reachability = Reachability()
    
    // Identifiers
    let reuseIdentifier = "rocketLaunchCell"
    
    // Create Activity Indicator
    var activityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Create view model instance with dependancy injection
        viewModel = RocketLaunchesModel(view: self)
        
        //Networking pillows
        if reachability!.connection != .none {
            print("connected to the Internet")
            viewModel.fetchLaunches {
                DispatchQueue.main.async { [weak self] in
                    print(self?.viewModel ?? 0)
                    print(self?.viewModel.launches.collection![0].missionDesc)
                    self?.tableView.reloadData()
                }
            }
        } else {
            print("unconnected")
            // create "Connect to Internet" overlay here
            let alert = UIAlertController(title: "Network Error", message: "The data may be unable to load from servers at this time. Please check your Internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged(note: )), name: Notification.Name.reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToLaunch", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get current Launch
        let launch = launchForIndexPath(sender as! IndexPath)
        
        if segue.identifier == "segueToLaunch" {
            // Get a reference to the second view controller
            if let vc = segue.destination as? RocketLaunchController {
                // Set weak reference to new view controller in viewModel
                viewModel.viewCell = vc
                // Set properties...
                vc.launch = launch
                if let launchId = launch.id {
                    vc.launchSaved = viewModel.isLaunchSavedFor(launchId: launchId)
                }
            }
        }
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")
        let reachability = note.object as! Reachability
        if reachability.connection == .none {
            // create overlay or alert?
            let alert = UIAlertController(title: "Network Error", message: "The data may be unable to load from servers at this time. Please check your Internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            // also, you need to stop making stuff load, so the user can navigate to other tabs
        } else {
            print("load the data now")
            viewModel.fetchLaunches {
                DispatchQueue.main.async { [weak self] in
                    print(self?.viewModel ?? 0)
                    print(self?.viewModel.launches.collection![0].missionDesc)
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
}


// MARK: - Private
private extension RocketLaunchesController {
    func launchForIndexPath(_ indexPath: IndexPath) -> RocketLaunch {
        return viewModel.launches.collection?[(indexPath as NSIndexPath).row] ?? RocketLaunch()
    }
}

// MARK: - UITableViewDataSource
extension RocketLaunchesController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.launches.collection?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! RocketLaunchCell
        cell.backgroundColor = UIColor.clear
        // Get the correct launch for the row
        cell.launch = launchForIndexPath(indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // This will override the height selected in the storyboard.
        return self.view.bounds.size.width / 1.1
    }
    
    // TODO: Load more launches when user scrolls to the bottom?
}

extension RocketLaunchesController: RocketLaunchesControllerDelegate {
    func isWaitingForData(_ isLoading: Bool) {
        isLoading ? startSpinner() : stopSpinner()
    }
    
    func startSpinner() {
        if activityIndicator == nil {
            //Create Activity Indicator
            activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            
            // Position Activity Indicator in the center of the main view
            activityIndicator.center = tableView.center
            
            // Acivity Indicator is hidden when stopAnimating() is called
            activityIndicator.hidesWhenStopped = false // Yikes
            
            // Add AI to tableview
            tableView.addSubview(activityIndicator)
        }
        
        // Start Activity Indicator
        activityIndicator.startAnimating()
    }
    
    func stopSpinner() {
        // Stop activity indicator
        activityIndicator.startAnimating() // Again, yikes. However, it works, so let's keep it that way for the inital release and fix it later. The app has bigger problems...
        activityIndicator.layer.zPosition = -1
    }
}
