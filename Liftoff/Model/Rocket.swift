//
//  Rocket.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

struct Rocket: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case configuration
        case familyName = "familyname"
        case agencies
        case wikiURL
        case imageURL
    }
    
    let id: Int
    let name: String
    let configuration: String
    let familyName: String
    let agencies: [Agency]
    let wikiURL: URL?
    let imageURL: URL
}
