//
//  AlertTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 6/13/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import UserNotifications
import NotificationCenter

class AlertTableViewController: UITableViewController {

    @IBAction func clearNotifications(_ sender: Any) {
        RecentNotificaion().recents.removeAll()
        alertTitles.removeAll()
        alertBodies.removeAll()
        alertDates.removeAll()
        self.tableView.reloadData()
    }
    
    var alertTitles = [String]()
    var alertBodies = [String]()
    var alertDates = [Date]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // This is money. Below is the code to get the notifications and display them.
        let center = UNUserNotificationCenter.current()
        center.getDeliveredNotifications(completionHandler: { requests in
            if requests.isEmpty {
                let alert = UIAlertController(title: "Nothing here", message: "It looks like there are no notifications.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                for request in requests {
                    self.alertBodies.append(request.request.content.body)
                    self.alertTitles.append(request.request.content.title)
                    self.alertDates.append(request.date)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RecentNotificaion().recents.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alertsIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = alertTitles[indexPath.row]
        cell.detailTextLabel?.text = alertBodies[indexPath.row]
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
