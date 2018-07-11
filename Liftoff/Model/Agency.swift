//
//  Agency.swift
//  Liftoff
//
//  Created by Matthew Turk on 7/10/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

enum AgencyType: Int, Codable {
    case unknown
    case government
    case multinational
    case commercial
    case educational
    case `private`
    
    init(_ rawValue: Int) {
        self = AgencyType(rawValue: rawValue) ?? .unknown
    }
}

struct Agency: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case abbreviation = "abbrev"
        case countryCode
        case type
        case infoURLs
        case wikiURL
    }
    
    let id: Int
    let name: String
    let abbreviation: String
    let countryCode: String
    let type: AgencyType
    let infoURLs: [URL]
    let wikiURL: URL?
}

