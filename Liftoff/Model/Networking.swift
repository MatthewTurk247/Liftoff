//
//  Networking.swift
//  Liftoff
//
//  Created by Matthew Turk on 4/8/20.
//  Copyright © 2020 MonitorMOJO, Inc. All rights reserved.
//

import Foundation

class Networking {
    
    //should not be initialised
    private init() { }
    
    static func sendRequest(with path: String, completion: @escaping (Result<Data, ConnectionError>) -> Void) {
        
        guard let url = URL(string: path) else {
            completion(.failure(.couldNotGetDetails))
            return
        }
        
        let urlSesion = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = urlSesion.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(.couldNotGetDetails))
                return
            }
            
            completion(.success(data))
            
        }
        
        task.resume()
        
    }
    
}

enum ConnectionError: Error {
    case couldNotGetDetails
}
