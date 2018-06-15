//
//  Rocket.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation
import UIKit

class Rocket: NSObject, NSCoding {
    
    var id: Int?
    var name: String?
    var agencies: Array<[String:AnyObject]>?
    var imageString: String? // URL
    var image: UIImage = #imageLiteral(resourceName: "default")
        
    
    convenience init (id: Int, name: String, agencies: Array<[String:AnyObject]>, imageString: String) {
        self.init()
        self.id = id
        self.name = name
        self.agencies = agencies
        self.imageString = imageString
        // Async dl image
        UIImage().imageFromServer(urlString: imageString) { (image) in
            self.image = image
        }
    }
    
    convenience init (id: Int, name: String, agencies: Array<[String:AnyObject]>, imageString: String, image: UIImage) {
        self.init()
        self.id = id
        self.name = name
        self.agencies = agencies
        self.imageString = imageString
        self.image = image
    }
    
    // MARK: NSCoding - Used to archive custom class (object) to NSData for storage
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        guard   let name = aDecoder.decodeObject(forKey: "name") as? String,
            let agencies = aDecoder.decodeObject(forKey: "agencies") as? Array<[String:AnyObject]>,
            let imageString = aDecoder.decodeObject(forKey: "imageString") as? String,
            let image = aDecoder.decodeObject(forKey:"image") as? UIImage
            else { return nil }
        
        // Create object
        self.init (id : id, name : name, agencies : agencies, imageString : imageString, image : image)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(agencies, forKey: "agencies")
        aCoder.encode(imageString, forKey: "imageString")
        aCoder.encode(image, forKey:"image")
    }
}

