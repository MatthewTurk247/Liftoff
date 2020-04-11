//
//  MissionsDetailViewController.swift
//  Rockety
//
//  Created by Antoine Bellanger on 22.05.18.
//  Copyright © 2018 Antoine Bellanger. All rights reserved.
//

import UIKit
import Alamofire

class MissionsDetailViewController: UITableViewController {
    
    typealias CompletionHandler = (_ success:Bool) -> Void
    
    var isSpaceX: Bool!
    var downloaded = false
    var isComingFromAgency = false
    
    var mission: Mission!
    var rocket: Rocket!
    var launchpad: Launchpad!
    
    var launch: ElseMission.Launch!
    var rocketAPI: API.Rocket = .rocket999
    
    var missionPayloadType: Payloads = .notAvailable
    
    override func viewDidLoad() {
        
    }

}
