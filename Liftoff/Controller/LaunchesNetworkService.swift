//
//  LaunchesNetworkService.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/6/20.
//  Copyright © 2020 MonitorMOJO, Inc. All rights reserved.
//


import Foundation

//generally this would be in a URLBuilder with separate parameters for version, path, number of launches etc but since this app is only dealing with one request, I am leaving it here
private let launchesPath = "https://launchlibrary.net/1.4/launch/next/10"

class LaunchesNetworkService: LaunchesServiceable {
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void) {
        
        Networking.sendRequest(with: launchesPath) { (result) in
            
            guard let resultData = try? result.get(), let launchesResponse: LaunchesResponse = Parser.decode(data: resultData) else {
                completion(.failure(ConnectionError.couldNotGetDetails))
                return
            }
            completion(.success(launchesResponse))
            
        }
        
    }
    
}

class Parser {
    
    //should not be initialised
    private init() { }
    
    static func decode<T: Codable>(data: Data) -> T? {
        
        let decoder = JSONDecoder()
        let result = try? decoder.decode(T.self, from: data)
        return result
        
    }
    
}


protocol LaunchesServiceable {
    
    func fetchLaunches(completion: @escaping (Result<LaunchesResponse, ConnectionError>) -> Void)
    
}
