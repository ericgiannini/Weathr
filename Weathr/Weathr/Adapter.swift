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
