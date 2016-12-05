//
//  DailyWeather.swift
//  Weathr
//
//  Created by Eric Giannini on 12/5/16.
//  Copyright © 2016 Unicorn Mobile, LLC. All rights reserved.
//

import Foundation


struct DailyWeather {
        
        var data: NSArray?

        init(infoObj : [String:Any], adapter:Adapter) {
            
            self.adapter = adapter
            
            if let data = infoObj["data"] as? NSArray {
                self.data = data
            }
        }

}
    
