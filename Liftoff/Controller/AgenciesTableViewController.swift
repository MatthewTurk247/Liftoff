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

class AgenciesTableViewController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {

    // MARK: - Data Source
    lazy var continents: [Continent] = {
        return Continent.continents()
    }()
    
    // Identifiers
    let reuseIdentifier = "agencyCell"
    var searchController: UISearchController!
    
    // gotta fix the keyboard stuff
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Create view model instance with dependancy injection
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Agencies..."
        searchController.searchBar.scopeButtonTitles = ["All", "Governmental", "Commercial"]
        searchController.searchBar.searchBarStyle = .prominent
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        self.title = "Agencies"
        searchController.searchBar.tintColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
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
        let currentLocale = NSLocale.current
        if let c =  currentLocale.localizedString(forRegionCode: a.countryCode) {
            switch a.type {
            case .multinational:
                cell.detailTextLabel?.text = "Multinational Organization"
            case .government:
                cell.detailTextLabel?.text = "Government of \(c)"
            case .educational:
                cell.detailTextLabel?.text = "Educational Institution in \(c)"
            case .commercial:
                cell.detailTextLabel?.text = "Company from \(c)"
            case .`private`:
                cell.detailTextLabel?.text = "Private Entity from \(c)"
            case .unknown:
                cell.detailTextLabel?.text = a.countryCode
            }
        } else {
            cell.detailTextLabel?.text = ""
        }
        cell.textLabel?.text = a.name

        cell.imageView?.image = UIImage(named: a.abbreviation)
        return cell
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Check your Internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: SegueID.launchDetail, sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else { continents = Continent.continents(); tableView.reloadData(); return }
        
        for i in 0...5 {
            continents[i].agencies = Continent.continents()[i].agencies.filter({ (agency) -> Bool in
                
                switch searchBar.selectedScopeButtonIndex {
                case 0:
                    if searchText.isEmpty { return true }
                    return agency.name.lowercased().contains(searchText.lowercased()) || agency.abbreviation.lowercased().contains(searchText.lowercased())
                case 1:
                    if searchText.isEmpty { return agency.type == .government }
                    return agency.name.lowercased().contains(searchText.lowercased()) || agency.abbreviation.lowercased().contains(searchText.lowercased()) && agency.type == .government
                case 2:
                    if searchText.isEmpty { return agency.type == .commercial }
                    return agency.name.lowercased().contains(searchText.lowercased()) || agency.abbreviation.lowercased().contains(searchText.lowercased()) && agency.type == .commercial
                default:
                    return false
                }
                
                //print(agency.name.lowercased().contains(searchText.lowercased()))
                //return agency.name.lowercased().contains(searchText.lowercased()) || agency.abbreviation.lowercased().contains(searchText.lowercased())
                // also should do if it contains the country
            })
        }
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            continents = Continent.continents()
        case 1:
            for i in 0...5 {
                continents[i].agencies = Continent.continents()[i].agencies.filter({ (agency) -> Bool in
                    agency.type == .government
                })
            }
        case 2:
            for i in 0...5 {
                continents[i].agencies = Continent.continents()[i].agencies.filter({ (agency) -> Bool in
                    agency.type == .commercial
                })
            }
        default:
            continents = Continent.continents()
        }
        searchBar.text = ""
        tableView.reloadData()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get current Launch
        if segue.identifier == "showAgency" {
            if let vc = segue.destination as? AgencyController, let i = tableView.indexPathForSelectedRow {
                vc.agency = continents[i.section].agencies[i.row]
            } else {
                print("uh oh Speghettios")
            }
        }
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
