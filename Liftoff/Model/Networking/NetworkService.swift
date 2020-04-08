//
//  NetworkService.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/18.
//  Copyright © 2018 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

struct NetworkService {
    
    static let sharedInstance = NetworkService()
    
    func fetchRocketLaunches(amount: Int, completionHandler: @escaping ([RocketLaunch]?) -> ()){
        // TODO: Use TRON or Alamofire for API calls
        let api = LaunchLibraryAPI()
        api.searchLibraryForLaunch(amount: amount, completion: {data, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                LaunchLibraryAPIHandler().handleLaunchLibraryData(launches: data, completion: { (rocketLaunches, error) in
                    if let error = error {
                        print(error)
                    }
                    if let rocketLaunches = rocketLaunches {
                        completionHandler(rocketLaunches)
                    } else {
                        completionHandler(nil)
                    }
                })
            }
        })
    }
    
    func fetchRocketImage(imageURL: URL, completionHandler: @escaping (Data?) -> ()) {
        DispatchQueue.main.async {
            if let imageData = try? Data(contentsOf: imageURL){
                completionHandler(imageData)
            } else {
                completionHandler(nil)
            }
        }

//        DispatchQueue.global(qos: .userInitiated).async {
//            EUREKA! So I forwent this method, and now the image shows immediately instead of having to scroll
//        }
    }
}
