//
//  Launch.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

struct ElseMission: Codable {
    
    let total: Int!
    let offset: Int!
    let count: Int!
    
    struct Launch: Codable {

        let id: Int!
        let name: String!
        let windowstart: String!
        let windowend: String!
        let net: String!
        let status: Int!
        
        let vidURLs: [String]?
        let infoURLs: [String]?
        let location: Location!
        let rocket: Rocket!
        let missions: [Mission]!
        let lsp: LaunchServiceProvider!
        
        struct Location: Codable {
            let id: Int!
            let name: String!
            let countryCode: String!
            let pads: [Pads]
            
            struct Pads: Codable {
                let id: Int!
                let name: String!
                let latitude: Double!
                let longitude: Double!
            }
        }
        
        struct Rocket: Codable {
            let id: Int!
            let name: String!
            let agencies: [Agency]?
            
            struct Agency: Codable {
                let name: String!
                let countryCode: String!
            }
        }
        
        struct LaunchServiceProvider: Codable {
            let id: Int!
            let name: String!
            let countryCode: String!
        }
        
        struct Mission: Codable {
            let id: Int!
            let name: String!
            let description: String!
            let typeName: String!
            let type: Int!
        }
        
    }

    let launches: [Launch]
}


