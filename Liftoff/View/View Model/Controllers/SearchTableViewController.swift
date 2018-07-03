//
//  SearchTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/13/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import Alamofire

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    var viewModel: RocketLaunchesModel!
    var resultTitles:Array<String> = []
    var resultDatesText:Array<String> = []
    let searchBar = UISearchBar()
    
    func makeGetCallWithAlamofire(term: String) {
        let todoEndpoint: String = "https://launchlibrary.net/1.2/launch?name=\(term)"
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                let launches = json["launches"] as! [NSDictionary]
                
                self.resultTitles.removeAll()
                self.resultDatesText.removeAll()
                
                for launch in launches {
                    print(String(describing: launch["net"]!).dropLast(13))
                    self.resultDatesText.append(String(describing: String(describing: launch["net"]!).dropLast(13)))
                    print(launch["name"]!)
                    self.resultTitles.append(String(describing: launch["name"]!))
                }
                self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for past or current rockets"
        searchBar.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // the UIViewController comes with a navigationItem property
        // this will automatically be initialized for you if when the
        // view controller is added to a navigation controller's stack
        // you just need to set the titleView to be the search bar
        navigationItem.titleView = searchBar
        self.hideKeyboardWhenTappedAround()

        //let searchTerm = "falcon"
        //var url : String = "https://launchlibrary.net/1.2/launch?name=\(searchTerm)"
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
        return resultTitles.count
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        makeGetCallWithAlamofire(term: searchBar.text!)
        UIApplication.shared.sendAction("resignFirstResponder", to: nil, from: nil, for: nil)
        self.tableView.reloadData()
        // There's still an issue: the arrays need to be cleared before each search, and the first time the user presses the search button, nothing happens...
        // Remember do catch...that's key
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "search", for: indexPath)

        cell.textLabel?.text = resultTitles[indexPath.row]
        cell.detailTextLabel?.text = resultDatesText[indexPath.row]
        cell.isUserInteractionEnabled = false

        return cell
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
