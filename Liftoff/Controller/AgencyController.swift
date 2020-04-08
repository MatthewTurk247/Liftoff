//
//  AgencyTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/18/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxMoya
import Moya
import SafariServices

class AgencyController: UITableViewController, SFSafariViewControllerDelegate {

    var agency: Agency?
    @IBOutlet var agencyLogoView: UIImageView!
    @IBOutlet var agencyDescriptionLabel: UILabel!
    private var isFetching = false
//    private let provider = MoyaProvider<API>().rx
    private let disposeBag = DisposeBag()
    fileprivate var launchResults = LaunchPageResults()
    private var loadingView = LoadingView()
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.title = agency!.name.count > 28 ? agency?.abbreviation : agency?.name
        agencyLogoView.image = UIImage(named: agency!.abbreviation)
        let slp = SwiftLinkPreview(session: .shared,
                                   workQueue: SwiftLinkPreview.defaultWorkQueue,
                                   responseQueue: .main,
                                   cache: DisabledCache.instance)
       /* if let w = agency?.wikiURL {
            slp.preview((w.absoluteString),
                        onSuccess: { result in print("\(result)"); self.agencyDescriptionLabel.text = result[SwiftLinkResponseKey.description] as! String },
                        onError: { error in print("\(error)")})
        } else if let o = agency?.infoURLs[0] {
            slp.preview((o.absoluteString),
                        onSuccess: { result in print("\(result)"); self.agencyDescriptionLabel.text = result[SwiftLinkResponseKey.description] as! String },
                        onError: { error in print("\(error)")})
        } else {
            self.agencyDescriptionLabel.text = "No description is available."
        }*/
//        fetchNextPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else {
            return launchResults.agencyLaunches.isEmpty ? nil : "Upcoming Launches"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return (agency?.infoURLs.count)!
        } else {
            return launchResults.agencyLaunches.count // return the number of launches
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "agencyDetail", for: indexPath)

        // Configure the cell...
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Official Website"
            } else {
                cell.textLabel?.text = agency?.infoURLs[indexPath.row].host
            }
            cell.detailTextLabel?.text = agency?.infoURLs[indexPath.row].absoluteString
        } else {
//            if let m = launchResults.agencyLaunches[indexPath.row].missions.first {
//                cell.textLabel?.text = m.name
//            } else {
//                cell.textLabel?.text = "Untitled Launch"
//            }
            cell.detailTextLabel?.text = launchResults.agencyLaunches[indexPath.row].location.name
        }

        return cell
    }
    
//    fileprivate func fetchNextPage() {
//        guard !isFetching else { return }
//        
//        isFetching = true
//        provider
//            .request(.showLaunches(page: launchResults.pagesFetched))
//            .asObservable()
//            .mapModel(model: LaunchResponse.self)
//            .subscribe { [weak self] (event) in
//                self?.loadingView.hide()
//                switch event {
//                case .next(let response):
//                    self?.handleFetchComplete(with: response.launches, total: response.total)
//                case .error(let error):
//                    self?.handleError(error)
//                case .completed:
//                    self?.isFetching = false
//                }
//            }
//            .disposed(by: disposeBag)
//    }
    
    private func handleFetchComplete(with launches: [Launch], total: Int) {
        launchResults.appendPage(with: launches, total: total)
        // authorizeAndRegisterNotifications(with: launchResults.launches)
        launchResults.agencyLaunches = launchResults.launches.filter({ (launch) -> Bool in
            launch.rocket.agencies?.first?.name == agency?.name
        })
        tableView.reloadData()
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Error", message: "Something went wrong. Check your Internet connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = SFSafariViewController(url: agency!.infoURLs[indexPath.row], entersReaderIfAvailable: false)
            vc.preferredControlTintColor = Color.exodusFruit
            vc.delegate = self
            present(vc, animated: true)
        } else {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RocketLaunchController") as? RocketLaunchController
            vc?.launch = launchResults.agencyLaunches[indexPath.row]
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
