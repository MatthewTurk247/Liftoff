//
//  Location.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let id: Int
    let name: String
    let countryCode: String
    let pads: [Pad]
}
