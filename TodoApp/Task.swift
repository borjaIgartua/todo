//
//  Task.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding { //si no heredamos de NSObject, NSCoding no funciona...
    var title: String
    var message: String?
    var done: Bool = false
    
    init(title: String, message: String?) {
        self.title = title
        self.message = message
    }
    
    init?(_ dic: [String: Any]) {
        
        guard let title = dic["title"] else {
            return nil
        }
        
        let message = dic["message"]
        let done = dic["done"]
        
        self.title = title as! String
        self.message = message as? String
        self.done = done as? Bool ?? false
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.message = decoder.decodeObject(forKey: "message") as? String
        self.done = decoder.decodeBool(forKey: "done")
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(message, forKey: "message")
        coder.encode(done, forKey: "done")
    }
}
