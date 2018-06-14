//
//  Constants.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

enum Config {
    // fileprivate - https://launchlibrary.net/1.4/launch
    //static let baseURL = "https://launchlibrary.net/1.4/launch"
    static let baseURL = "https://launchlibrary.net/1.4/launch"
    static let domain = "com.LaunchLibrary"
}

enum Color {
    static let exodusFruit = UIColor(red: 108/255, green: 92/255, blue: 231/255, alpha: 1)
    static let secondaryColor = UIColor.lightGray
    
    // A visual way to define colors within code files is to use #colorLiteral
    // This syntax will present you with colour picker component right on the code line
    //    static let tertiaryColor = #colorLiteral(r: g: b: a: )
    static let tertiaryColor = #colorLiteral(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
}
