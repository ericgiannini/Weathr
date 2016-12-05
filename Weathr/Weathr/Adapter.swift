//
//  Adapter.swift
//  Weathr
//
//  Created by Eric Giannini on 12/5/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import Foundation

enum HTTPMethod : String {
    case DELETE
    case GET
    case PUT
    case POST
}

public enum Result<T> {
    case success(T)
    case failure(Error)
    
    public init(value: T) {
        self = .success(value)
    }
    
    public init(error: Error) {
        self = .failure(error)
    }
}

public class Adapter {
    func makeRequest(method: HTTPMethod, path: String, headers: [String:String]?, payload: [String:Any]?, handler: @escaping (Result<[String:Any]>) -> ()) throws -> URLSessionDataTask {
        var request = URLRequest(url: URL(string: "https:\(path)")!)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        
        if let payload = payload {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                handler(Result(error: error))
                return
            }
            
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        handler(Result(value: json))
                        return
                    }
                } catch let error {
                    handler(Result(error: error))
                    return
                }
            }
            
            fatalError("should not ever occur.") // We are ignoring some theoretical error cases here
        }
        
        task.resume()
        return task
    }
}
