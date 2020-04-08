//
//  Mission.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/9/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

struct Mission: Codable {
    let id: Int
    let name, missionDescription: String
    let wikiURL: String
    let typeName: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case missionDescription = "description"
        case wikiURL, typeName
    }
}
