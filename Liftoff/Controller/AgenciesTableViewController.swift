//
//  AgenciesTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/12/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Moya
import RxCocoa
import RxSwift
import UIKit
import Foundation

class AgenciesTableViewController: UITableViewController, UISearchBarDelegate {
    
    private var loadingView = LoadingView()
    var setupIterator = 0
    
    //To check Internet connection
    var reachability = Reachability()
    
    // MARK: - Data Source
    
    lazy var continents: [Continent] = {
        return Continent.continents()
    }()
    
    var agenciesArray = [Agency]()
    
    // Identifiers
    let reuseIdentifier = "agencyCell"
    
    // Create Activity Indicator
    var activityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Create view model instance with dependancy injection
        self.title = "Agencies"
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return continents.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents[section].agencies.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return continents[section].name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        //swiftlint:enable force_cast
        let a = continents[indexPath.section].agencies[indexPath.row]
        var t = ""
        switch a.type {
        case .multinational:
            t = "Multinational"
        case .government:
            t = "Governmental"
        case .educational:
            t = "Educational"
        case .commercial:
            t = "Commercial"
        case .`private`:
            t = "Private"
        case .unknown:
            t = ""
        }
        cell.textLabel?.text = a.name
        cell.detailTextLabel?.text = t  + " " + a.countryCode.flag()
        return cell
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong. Try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: SegueID.launchDetail, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get current Launch
//        if segue.identifier == SegueID.launchDetail {
//
//            if let vc = segue.destination as? RocketLaunchController, let i = sender as? IndexPath {
//                vc.launch = agencyResults.currentLaunches[i.row]
//            } else {
//                print("uh oh Speghettios")
//            }
//        }
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")
        
    }
    
}
