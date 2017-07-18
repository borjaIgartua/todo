//
//  User.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

struct User {
    var identifier: Int
    var username: String
    var password: String
    
    init?(dic: [String: Any]) {
        
        guard let identifier = dic["id"] else {
            return nil
        }
        
        let username = dic["username"]
        let password = dic["password"]
        
        self.identifier = identifier as! Int
        self.username = username as? String ?? ""
        self.password = password as? String ?? ""
    }
}
