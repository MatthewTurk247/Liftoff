//
//  NewsSafariViewController.swift
//  Liftoff
//
//  Created by Matthew Turk on 5/6/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import UIKit
import SafariServices

class NewsSafariViewController: UIViewController {

    let link = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: "https://www.hackingwithswift.com/read") {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
