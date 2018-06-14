//
//  Mission.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/9/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

class Mission : NSObject, NSCoding {
    
    var desc: String?
    
    
    convenience init (desc: String) {
        self.init()
        self.desc = desc
    }
    
    // MARK: NSCoding - Used to archive custom class (object) to NSData for storage
    required convenience init?(coder aDecoder: NSCoder) {
        guard let desc = aDecoder.decodeObject(forKey: "description") as? String else { return nil }
        
        // Create object
        self.init (desc: desc)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(desc, forKey: "description")
    }
}
