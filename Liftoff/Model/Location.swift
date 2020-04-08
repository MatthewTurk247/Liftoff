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
    private let pads: [Pad]
    let id: Int
    let name: String
    let countryCode: String
    var coordinate: CLLocationCoordinate2D? {
        guard let pad = pads.first else { return nil }
        return CLLocationCoordinate2D(latitude: pad.latitude, longitude: pad.longitude)
    }
}
