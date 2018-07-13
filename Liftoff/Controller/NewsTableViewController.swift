//
//  NewsTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/14/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SafariServices
import Moya
import RxCocoa
import RxSwift

class NewsTableViewController: UITableViewController {
    
    var reachability = Reachability()
    private let provider = MoyaProvider<API>().rx
    private let notificationManager = NotificationManager<Launch>()
    private let disposeBag = DisposeBag()
    
    fileprivate var launchResults = LaunchPageResults()
    private var isFetching = false
    private var loadingView = LoadingView()
    var liveLaunches = Array<Launch>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.title = "Live"
        fetchNextPage()
        
        // Networking
        
        if reachability!.connection == .none {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsIdentifier", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        if !launchResults.launches.isEmpty {
            if launchResults.launches[indexPath.row].videoURLs.first != nil {
                cell.configure(with: launchResults.launches[indexPath.row])
                //print(launchResults.launches[indexPath.row].videoURLs.first!)
            } else {
                cell.contentView.frame.size.height = CGFloat(0)
            }
        }
        
        return cell
    }
    
    @objc func internetChanged(note: Notification) {
        print("internet changed at \(Date())")
        let reachability = note.object as! Reachability
        if reachability.connection != .none {
            print("load the data now")
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true)
        } else {
            // create overlay?
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
        tableView.reloadData()
    }
    
    private func handleError(_ error: Swift.Error) {
        let alert = UIAlertController(title: "Oops", message: "Something went wrong. Try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard launchResults.canFetchMoreLaunches else { return }
        let bottomOffset = scrollView.contentSize.height - scrollView.bounds.height
        if scrollView.contentOffset.y > bottomOffset - 60.0 {
            // 60 points from the bottom of the list
            fetchNextPage()
        }
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

    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "newsSegue", sender: indexPath)
        
        if reachability!.connection == .none {
            let alert = UIAlertController(title: "Network Error", message: "Please check your Internet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // present
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/

}
