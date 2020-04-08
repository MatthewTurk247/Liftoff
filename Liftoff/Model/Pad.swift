//
//  Pad.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import CoreLocation

private struct Pad: Codable {
    let id: Int
    let name: String
    let infoURL: String?
    let wikiURL: String?
    let mapURL: String?
    let latitude, longitude: Double
}


//extension Pad {
//    var infoURL: URL? {
//        return infoURLString.flatMap(URL.init)
//    }
//    var wikiURL: URL? {
//        return wikiURLString.flatMap(URL.init)
//    }
//    var mapURL: URL? {
//        return mapURLString.flatMap(URL.init)
//    }
//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//}
