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
        //        viewModel.isLoading.bind { [unowned self]
        //            self.isWaitingForData($0)
        //        }
        viewModel.fetchLaunches {
            DispatchQueue.main.async { [weak self] in
                print(self?.viewModel ?? 0)
                print(self?.viewModel.launches.collection![0].missionDesc)
                self?.tableView.reloadData()
            }
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
            activityIndicator.hidesWhenStopped = false // yikes
            
            // Add AI to tableview
            tableView.addSubview(activityIndicator)
        }
        
        // Start Activity Indicator
        activityIndicator.startAnimating()
    }
    
    func stopSpinner() {
        // Stop activity indicator
        activityIndicator.stopAnimating()
    }
}
