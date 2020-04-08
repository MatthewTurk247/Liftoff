//
//  Response.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/6/20.
//  Copyright © 2020 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

public struct Response {
    
    public internal(set) var url: URL?
    public internal(set) var finalUrl: URL?
    public internal(set) var canonicalUrl: String?
    public internal(set) var title: String?
    public internal(set) var description: String?
    public internal(set) var images: [String]?
    public internal(set) var image: String?
    public internal(set) var icon: String?
    public internal(set) var video: String?
    public internal(set) var price: String?
    
    public init() { }
    
}
