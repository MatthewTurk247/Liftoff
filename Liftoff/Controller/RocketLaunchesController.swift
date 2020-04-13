//
//  RocketLaunchesController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import GoogleMobileAds

class RocketLaunchesController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate, RocketSearchControllerDelegate, UIViewControllerPreviewingDelegate, GADUnifiedNativeAdLoaderDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var spaceXMissions = [Mission]()
    var filteredSpaceXMissions = [Mission]()
    
    var elseLaunches: ElseMission!
    var filteredElseLaunches = [ElseMission.Launch]()
    var tableViewItems = [Any]()
    var detailViewController: MissionsDetailViewController? = nil
    
    var downloaded = false
    
    var missionId: String?
    
    let refreshControl = UIRefreshControl()
    
    var currentIndex = 0
    
    var shouldShowSearchResults = false
    var rocketSearchController: RocketSearchController!
    
    var selectedLaunchIndex: Int!
    
    let adUnitID = "ca-app-pub-2723394137854237/3550355591"
    let numAdsToLoad = 8
    /// The native ads.
    var nativeAds = [GADUnifiedNativeAd]()
    /// The ad loader that loads the native ads.
    var adLoader: GADAdLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        //        tableView.emptyDataSetDataSource = self
        //        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        //        tableView.addSubview(refreshControl)
        tableView.estimatedRowHeight = 145
        tableView.rowHeight = UITableView.automaticDimension
        //        tableView.backgroundColor = UIColor(red: 17 / 255, green: 30 / 255, blue: 60 / 255, alpha: 1)
        //
        //        view.backgroundColor = UIColor(red: 17 / 255, green: 30 / 255, blue: 60 / 255, alpha: 1)
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        tableView.register(UINib(nibName: "UnifiedNativeAdCell", bundle: nil), forCellReuseIdentifier: "UnifiedNativeAdCell")
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count - 1] as! UINavigationController).topViewController as? MissionsDetailViewController
        }
        
        configureRocketSearchController()
        
        downloadSpaceX()
        downloadAll()
        
        let options = GADMultipleAdsAdLoaderOptions()
        options.numberOfAds = numAdsToLoad
        
        // Prepare the ad loader and start loading ads.
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: self,
                               adTypes: [.unifiedNative],
                               options: [options])
        adLoader.delegate = self
        adLoader.load(GADRequest())
        tableView.register(UINib(nibName: "UnifiedNativeAdCell", bundle: nil),
                           forCellReuseIdentifier: "UnifiedNativeAdCell")
        
    }
    
    // MARK: Data - SpaceX
    
    @objc func downloadSpaceX() {
        AF.request(API.SpaceX.allLaunches.url()).responseJSON { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                let decodedMissions = try! decoder.decode([Mission].self, from: data)
                self.spaceXMissions = decodedMissions
            }
        }
    }
    
    // MARK: Data - Else
    
    @objc func downloadAll() {
        AF.request(API.All.nextLaunches.url()).responseJSON { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                let decodedLaunches = try! decoder.decode(ElseMission.self, from: data)
                self.elseLaunches = decodedLaunches
                self.tableViewItems.append(contentsOf: decodedLaunches.launches)
                
                DispatchQueue.main.async {
                    print("Downloaded Everything")
                    //                    self.setupElseSearchableContent()
                    self.refreshControl.endRefreshing()
                    self.downloaded = true
                    self.tableView.reloadData()
                    
                    // Deeplink handling
                    if self.missionId != nil {
                        self.performSegue(withIdentifier: "performDeeplink", sender: self)
                    }
                }
            }
        }
    }
    
    // MARK: UITableViewDataSource and UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return downloaded ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredElseLaunches.count
        } else {
            return elseLaunches.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let missionItem = shouldShowSearchResults ? filteredElseLaunches[indexPath.row] : tableViewItems[indexPath.row] as? ElseMission.Launch {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MissionCell", for: indexPath) as! MissionTableViewCell
            var delimiter = "|"
            var missionName = missionItem.name.components(separatedBy: delimiter)
            missionName[1].remove(at: missionName[1].startIndex)
            
            cell.missionNameLabel.text = missionName[1]
            cell.missionOperatorLabel.text = missionItem.lsp.name
            cell.missionRocketLabel.text = missionName[0]
            
            delimiter = ","
            var padName = missionItem.location.pads[0].name.components(separatedBy: delimiter)
            
            cell.missionLaunchSiteLabel.text = padName[0]
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss 'UTC'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            if let date = dateFormatter.date(from: missionItem.net) {
                let localizedDateTime: String = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .medium)
                cell.missionDateLabel.text = localizedDateTime
            } else {
                cell.missionDateLabel.text = missionItem.net
            }
            // later on let's switch the missionDaetLabel text color base on the status of the whether or not the launch will happen
            return cell
        } else {
            let nativeAd = tableViewItems[indexPath.row] as! GADUnifiedNativeAd
            /// Set the native ad's rootViewController to the current view controller.
            nativeAd.rootViewController = self

            let nativeAdCell = tableView.dequeueReusableCell(
                withIdentifier: "UnifiedNativeAdCell", for: indexPath)

            // Get the ad view from the Cell. The view hierarchy for this cell is defined in
            // UnifiedNativeAdCell.xib.
            let adView : GADUnifiedNativeAdView = nativeAdCell.contentView.subviews.first as! GADUnifiedNativeAdView

            // Associate the ad view with the ad object.
            // This is required to make the ad clickable.
            adView.nativeAd = nativeAd

            // Populate the ad view with the ad assets.
            (adView.headlineView as! UILabel).text = nativeAd.headline
            (adView.priceView as! UILabel).text = nativeAd.price
            if let starRating = nativeAd.starRating {
              (adView.starRatingView as! UILabel).text =
                  starRating.description + "\u{2605}"
            } else {
              (adView.starRatingView as! UILabel).text = nil
            }
            (adView.bodyView as! UILabel).text = nativeAd.body
            (adView.advertiserView as! UILabel).text = nativeAd.advertiser
            // The SDK automatically turns off user interaction for assets that are part of the ad, but
            // it is still good to be explicit.
            (adView.callToActionView as! UIButton).isUserInteractionEnabled = false
            (adView.callToActionView as! UIButton).setTitle(
                nativeAd.callToAction, for: UIControl.State.normal)
            
            return nativeAdCell
        }
        
    }
    
    // MARK: UISearchController
    
    func configureRocketSearchController() {
        rocketSearchController = RocketSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 50), searchBarFont: UIFont.systemFont(ofSize: 16), searchBarTextColor: UIColor.label, searchBarTintColor: UIColor.systemBackground)
        rocketSearchController.rocketSearchBar.placeholder = "Search"
        rocketSearchController.customDelegate = self
        
        tableView.tableHeaderView = rocketSearchController.rocketSearchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        
        if currentIndex == 0 {
            filteredSpaceXMissions = spaceXMissions.filter { (mission) -> Bool in
                let missionText: NSString = mission.mission_name as NSString
                
                return (missionText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            }
        } else {
            filteredElseLaunches = elseLaunches.launches.filter { (launch) -> Bool in
                let launchText: NSString = launch.name as NSString
                
                return (launchText.range(of: searchString!, options: .caseInsensitive).location) != NSNotFound
            }
        }
        
        tableView.reloadData()
    }
    
    // MARK: RocketSearchControllerDelegate
    
    func didStartSearching() {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func didChangeSearchText(searchText: String) {
        filteredElseLaunches = elseLaunches.launches.filter { (launch) -> Bool in
            let launchText: NSString = launch.name as NSString
            
            return (launchText.range(of: searchText, options: .caseInsensitive).location) != NSNotFound
        }
        
        tableView.reloadData()
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = tableView.indexPathForRow(at: self.view.convert(location, to: tableView)) else {
            print("IndexPath problem")
            return nil
        }
        
        print(indexPath)
        
        guard let cell = tableView.cellForRow(at: indexPath) else {
            print("Cell problem")
            return nil
        }
        
        guard let destVC = storyboard?.instantiateViewController(withIdentifier: "MissionsDetailViewController") as? MissionsDetailViewController else {
            return nil
        }
        
        //        if shouldShowSearchResults {
        //            destVC.isSpaceX = false
        //            destVC.launch = filteredElseLaunches[indexPath.row]
        //        } else {
        //            destVC.isSpaceX = false
        //            destVC.launch = elseLaunches.launches[indexPath.row]
        //        }
        
        destVC.preferredContentSize = CGSize(width: 0.0, height: 450)
        previewingContext.sourceRect = cell.frame
        
        return destVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMission" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let found = spaceXMissions.firstIndex { (mission) -> Bool in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    let spaceXDate = DateFormatter.localizedString(from: dateFormatter.date(from: mission.launch_date_local)!, dateStyle: .short, timeStyle: .medium)
                    
                    // Else
                    var elseDate = ""
                    
                    dateFormatter.dateFormat = "MMM d, yyyy HH:mm:ss 'UTC'"
                    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
                    
                    if shouldShowSearchResults {
                        elseDate = DateFormatter.localizedString(from: dateFormatter.date(from: filteredElseLaunches[indexPath.row].net)!, dateStyle: .short, timeStyle: .medium)
                    } else {
                        elseDate = DateFormatter.localizedString(from: dateFormatter.date(from: elseLaunches.launches[indexPath.row].net)!, dateStyle: .short, timeStyle: .medium)
                    }
                    
                    return spaceXDate == elseDate
                }
                
                var isSpaceX = false
                
                if found != nil {
                    isSpaceX = true
                }
                
                if shouldShowSearchResults {
                    let destVC = (segue.destination as! UINavigationController).topViewController as! MissionsDetailViewController
                    destVC.isSpaceX = isSpaceX
                    if isSpaceX {
                        destVC.mission = spaceXMissions[found!]
                    }
                    destVC.launch = filteredElseLaunches[indexPath.row]
                    destVC.hidesBottomBarWhenPushed = true
                    detailViewController = destVC
                } else {
                    let destVC = (segue.destination as! UINavigationController).topViewController as! MissionsDetailViewController
                    destVC.isSpaceX = isSpaceX
                    if isSpaceX {
                        destVC.mission = spaceXMissions[found!]
                    }
                    destVC.launch = tableViewItems[indexPath.row] as! ElseMission.Launch
                    destVC.hidesBottomBarWhenPushed = true
                    detailViewController = destVC
                }
            }
        } else if segue.identifier == "showMissionElseCS" {
            let destVC = segue.destination as! MissionsDetailViewController
            destVC.isSpaceX = false
            destVC.launch = elseLaunches.launches[selectedLaunchIndex]
            destVC.hidesBottomBarWhenPushed = true
        } else if segue.identifier == "performDeeplink" {
            guard let identifier = Int(missionId ?? "") else { return }
            let mission = elseLaunches.launches.filter { $0.id == identifier }
            guard mission.count > 0 else { return }
            let destVC = segue.destination as! MissionsDetailViewController
            destVC.isSpaceX = false
            destVC.launch = mission[0]
            destVC.hidesBottomBarWhenPushed = true
        }
    }
    
    func addNativeAds() {
      if nativeAds.count <= 0 {
        return
      }

      let adInterval = (tableViewItems.count / nativeAds.count) + 1
      var index = 2
      for nativeAd in nativeAds {
        if index < tableViewItems.count {
          tableViewItems.insert(nativeAd, at: index)
          index += adInterval
        } else {
          break
        }
      }
    }
    
    // MARK: - GADAdLoaderDelegate
    
    func adLoader(_ adLoader: GADAdLoader,
                  didFailToReceiveAdWithError error: GADRequestError) {
        print("\(adLoader) failed with error: \(error.localizedDescription)")
        
    }
    
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADUnifiedNativeAd) {
        print("Received native ad: \(nativeAd)")
        
        // Add the native ad to the list of native ads.
        nativeAds.append(nativeAd)
    }
    
    func adLoaderDidFinishLoading(_ adLoader: GADAdLoader) {
        addNativeAds()
        tableView.reloadData()
    }
    
}

