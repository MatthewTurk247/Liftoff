//
//  Mission.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/9/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

struct Mission: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case type = "typeName"
    }
    
    let id: Int
    let name: String
    let description: String
    let type: String
}

