//
//  MoreTableViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/14/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import UserNotifications

class MoreTableViewController: UITableViewController {

    
    @IBAction func openSettings(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    @IBAction func openAppStore(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/developer/monitormojo-inc/id1370996012")!)
    }
    
    @IBOutlet var enableNotificationsButton: UIButton!
    @IBOutlet var showLaunchNotifications: UISwitch!
    @IBOutlet var showFactNotifications: UISwitch!
    @IBOutlet var copyrightNoticeLabel: UILabel!
    
    @IBAction func launchValueChanged(_ sender: Any) {
        defaults.setValue(showLaunchNotifications.isOn, forKey: "allowNotifications")
        if showLaunchNotifications.isOn {
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    @IBAction func factValueChanged(_ sender: Any) {
//        if showFactNotifications.isOn {
//            NotificationManager().repeatNotification()
//        } else {
//            NotificationManager().stopNotification()
//        }
    }
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let version:AnyObject? = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as AnyObject
        self.copyrightNoticeLabel.text = "Liftoff v\(String(describing: version!))\n© MonitorMOJO, Inc. \(year). All rights reserved."
        
        // TODO: - Make the states of the UISwtich components represent the user defaults
        print(defaults.value(forKey: "allowDailyFact"), defaults.value(forKey: "allowNotifications"))
        self.showFactNotifications.isOn = (defaults.value(forKey: "allowDailyFact") != nil) as Bool
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if showFactNotifications.isOn {
//            NotificationManager().repeatNotification()
//        } else {
//            stopNotification()
//        }
//        checkNotificationEligibility()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
