//
//  Agency.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

struct AgencyResult: Codable {
    
    let total: Int!
    let offset: Int!
    let count: Int!
    
    struct Agency: Codable {
        let id: Int!
        let name: String!
        let countryCode: String!
        let abbrev: String!
        let type: Int!
    }
    
    let agencies: [Agency]
}
