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
import GoogleMobileAds

struct LaunchPageResults {
    var launches = [Launch]()
    var currentLaunches = [AnyObject]()
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

class RocketLaunchesController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating, GADBannerViewDelegate {
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
    var badAd = false
    
    // To check Internet connection
    var reachability = Reachability()
    
    // Identifiers
    let reuseIdentifier = "rocketLaunchCell"
    
    // Create Activity Indicator
    var activityIndicator:UIActivityIndicatorView!
    
    // LET'S MAKE THAT CASH MONEY
    
    /// The ad unit ID from the AdMob UI.
    let adUnitID = "ca-app-pub-2723394137854237/8321532673"
    
    /// The number of native ads to load (between 1 and 5 for this example).
    let numAdsToLoad = 5
    
    /// The native ads.
    var nativeAds = [GADUnifiedNativeAd]()
    
    /// The ad loader that loads the native ads.
    var adLoader: GADAdLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        // Create view model instance with dependancy injection
        tableView.keyboardDismissMode = .onDrag
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(openSearchBar))
        loadingView.showInView(view)
        fetchNextPage()
        
        let options = GADMultipleAdsAdLoaderOptions()
        options.numberOfAds = numAdsToLoad
        
        tableView.register(UINib(nibName: "UnifiedNativeAdCell", bundle: nil),
                           forCellReuseIdentifier: "UnifiedNativeAdCell")
        
        // Prepare the ad loader and start loading ads.
        adLoader = GADAdLoader(adUnitID: adUnitID,
                               rootViewController: self,
                               adTypes: [.unifiedNative],
                               options: [options])
        let r = GADRequest()
        r.testDevices = [kGADSimulatorID]
        adLoader.load(r)
        
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
            launchResults.currentLaunches = launchResults.launches as [AnyObject]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: LaunchCell.reuseID, for: indexPath) as! LaunchCell
            //swiftlint:enable force_cast
            if let item = launchResults.currentLaunches[indexPath.row] as? Launch {
                cell.configure(with: item)
            } else {
                let nativeAd = launchResults.currentLaunches[indexPath.row] as! GADUnifiedNativeAd
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
                    nativeAd.callToAction, for: UIControlState.normal)
                
                return nativeAdCell
            }
            return cell
        } else {
            return tableView.dequeueReusableCell(withIdentifier: PageLoadingCell.reuseID, for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // This will override the height selected in the storyboard.
        if badAd {
            return 0
        } else {
            return 135
        }
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
        
        guard !searchText.isEmpty else { launchResults.currentLaunches = launchResults.launches as [AnyObject]; tableView.reloadData(); return } // also unhide the spinner
        // hide spinner at the bottom
        launchResults.currentLaunches = launchResults.launches.filter { (launch) -> Bool in
            return launch.name.lowercased().contains(searchText.lowercased())
            } as [AnyObject]
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
        launchResults.currentLaunches = launchResults.launches as [AnyObject]
        tableView.reloadData()
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong. Try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addNativeAds() {
        if nativeAds.count <= 0 {
            return
        }
        
        let adInterval = (launchResults.currentLaunches.count / nativeAds.count) + 1
        var index = 0
        for nativeAd in nativeAds {
            if index < launchResults.currentLaunches.count {
                launchResults.currentLaunches.insert(nativeAd, at: index)
                index += adInterval
            } else {
                break
            }
        }
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
        print("did select row")
        performSegue(withIdentifier: SegueID.launchDetail, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get current Launch
        if segue.identifier == SegueID.launchDetail {
            
            if let vc = segue.destination as? RocketLaunchController, let i = sender as? IndexPath {
                vc.launch = launchResults.currentLaunches[i.row] as! Launch
            } else {
                print("uh oh Speghettios")
            }
        }
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")

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
        // enableMenuButton()
        print("adLoaderDidFinishLoading")
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        badAd = true
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}
