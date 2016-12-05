//
//  Client.swift
//  Weathr
//
//  Created by Eric Giannini on 12/5/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import Foundation

class Client {
    
    var adapter: Adapter!
    
    init(adapter: Adapter) {
        self.adapter = adapter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // parameter constructor will be initialized along with the initialization of the class object itself
    
    
    // getSpace method
    func requestDailyWeather(spaceId: String, handler: @escaping (Result<DailyWeather>) -> ()) {
        
        do {
            
            _ = try adapter.makeRequest(method: .GET,
                                        path: "/spaces/\(spaceId)",
                headers: nil,
                payload: nil) { result in
                    
                    switch result
                    {
                    case .success(let JSON):
                        
                        let dailyWeather = Space(infoObj: JSON, adapter: self.adapter)
                        
                        //                                            print(dailyWeather.data)
                        
                        handler(Result(value: dailyWeather))
                        
                    case .failure:
                        break
                    }
                    
                    
                    
            }
            
        }
        catch {
            print(error)
        }
        
        
    }
    
}
