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
    let id: Int
    let name: String
    let wikiURL: String
    let infoURLs: [String]
    let imageSizes: [Int]
    let imageURL: String
    let agencies: [Agency]
    
    var infoURL: URL? {
        if wikiURL.count > 0 {
            return URL(string: wikiURL)
        } else if let firstInfoURL = infoURLs.first, firstInfoURL.count > 0 {
            return URL(string: firstInfoURL)
        }
        return nil
    }
}
