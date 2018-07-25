//
//  RocketLaunchesController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Moya
import RxCocoa
import RxSwift
import UIKit
import Foundation

struct LaunchPageResults {
    var launches = [Launch]()
    var currentLaunches = [Launch]()
    var agencyLaunches = [Launch]()
    private(set) var launchTotal = 0
    private(set) var pagesFetched = 0
    
    var canFetchMoreLaunches: Bool {
        return launchTotal > launches.count
    }
    
    mutating func appendPage(with launches: [Launch], total: Int) {
        let now = Date()
        let toAppend = launches.filter { $0.windowOpenDate > now }
        let missing = launches.count - toAppend.count
        launchTotal = total - missing
        self.launches.append(contentsOf: toAppend)
        pagesFetched += 1
    }
}

struct LaunchResponseError: Swift.Error {}

class RocketLaunchesController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    private let provider = MoyaProvider<API>().rx
    private let notificationManager = NotificationManager<Launch>()
    private let disposeBag = DisposeBag()
    lazy var searchBar = UISearchBar()
    
    fileprivate var launchResults = LaunchPageResults()
    private var isFetching = false
    private var loadingView = LoadingView()
    var setupIterator = 0
    var searchActivated = false
    
    //To check Internet connection
    var reachability = Reachability()
    
    // Identifiers
    let reuseIdentifier = "rocketLaunchCell"
    
    // Create Activity Indicator
    var activityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Create view model instance with dependancy injection
        tableView.keyboardDismissMode = .onDrag
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchBar))
        loadingView.showInView(view)
        fetchNextPage()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return launchResults.currentLaunches.count
        } else if launchResults.launches.count < launchResults.launchTotal {
            // show the page cell
            return 1
        } else {
            // hide the page cell
            return 0
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        guard launchResults.canFetchMoreLaunches else { return }
        let bottomOffset = scrollView.contentSize.height - scrollView.bounds.height
        if scrollView.contentOffset.y > bottomOffset - 60.0 {
            // 60 points from the bottom of the list
            fetchNextPage()
            launchResults.currentLaunches = launchResults.launches
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseID, for: indexPath) as! LaunchCell
            //swiftlint:enable force_cast
            cell.configure(with: launchResults.currentLaunches[indexPath.row])
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: PageLoadingCell.reuseID, for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // This will override the height selected in the storyboard.
        return 135
    }
    
    fileprivate func fetchNextPage() {
        guard !isFetching else { return }
        
        isFetching = true
        provider
            .request(.showLaunches(page: launchResults.pagesFetched))
            .asObservable()
            .mapModel(model: LaunchResponse.self)
            .subscribe { [weak self] (event) in
                self?.loadingView.hide()
                switch event {
                case .next(let response):
                    self?.handleFetchComplete(with: response.launches, total: response.total)
                case .error(let error):
                    self?.handleError(error)
                case .completed:
                    self?.isFetching = false
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else { launchResults.currentLaunches = launchResults.launches; tableView.reloadData(); return } // also unhide the spinner
        // hide spinner at the bottom
        launchResults.currentLaunches = launchResults.launches.filter { (launch) -> Bool in
            return launch.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    private func registerNotifications(with launches: [Launch]) {
        notificationManager.removePendingNotifications()
        notificationManager.registerNotifications(for: launches)
    }
    
    private func authorizeAndRegisterNotifications(with launches: [Launch]) {
        notificationManager.authorize()
            .subscribe { [weak self] (event) in
                switch event {
                case .next(let status):
                    if status == .granted {
                        self?.registerNotifications(with: launches)
                    }
                default:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func handleFetchComplete(with launches: [Launch], total: Int) {
        launchResults.appendPage(with: launches, total: total)
        authorizeAndRegisterNotifications(with: launchResults.launches)
        launchResults.currentLaunches = launchResults.launches
        tableView.reloadData()
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong. Try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func openSearchBar() {
        searchActivated = !searchActivated
        if searchActivated {
            navigationItem.titleView = searchBar
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(openSearchBar))
        } else {
            navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchBar))
        }
        // there's a sense of sequence in this code
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueID.launchDetail, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get current Launch
        if segue.identifier == SegueID.launchDetail {
            
            if let vc = segue.destination as? RocketLaunchController, let i = sender as? IndexPath {
                vc.launch = launchResults.currentLaunches[i.row]
            } else {
                print("uh oh Speghettios")
            }
        }
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")

    }
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
}
