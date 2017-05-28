//
//  URLExtension.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 26/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

extension URL {
    
    init?(string: String, params: [String: Any]?) {
        
        var completeURLString = string
        if let params = params as? [String: String], params.count > 0 {
            let lastKey = params.lastKey
           
            completeURLString += "?"
            for (key,param) in params {
                completeURLString += key + "=" + param
                
                if params[lastKey] != param {
                    completeURLString += "&"
                }
            }
        }
        
        self.init(string: completeURLString)
    }
}
