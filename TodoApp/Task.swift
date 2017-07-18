//
//  Task.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class Task: NSObject, NSCoding { //si no heredamos de NSObject, NSCoding no funciona...
    var identifier: Int?
    var title: String
    var message: String?
    var done: Bool = false
    
    var params: [String: Any]  {
        
        var result: [String:Any] = ["title" : self.title]
        
        if let message = self.message, message.length > 0 {
            result["message"] = message
        }
        
        if let identifier = self.identifier {
            result["id"] = identifier
        }
        
        result["done"] = self.done
        
        return result
    }
    
    init(title: String, message: String?) {
        self.title = title
        self.message = message
    }
    
    init?(_ dic: [String: Any]) {
        
        guard let identifier = dic["id"] else {
            return nil
        }
        
        guard let title = dic["title"] else {
            return nil
        }
        
        let message = dic["message"]
        let done = dic["done"]
        
        self.identifier = identifier as? Int
        self.title = title as! String
        self.message = message as? String
        self.done = done as? Bool ?? false
    }
    
    required init(coder decoder: NSCoder) {
        
        if let idenfierString = decoder.decodeObject(forKey: "identifier") as? String {
            self.identifier = Int(idenfierString)
        }
        
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.message = decoder.decodeObject(forKey: "message") as? String
        self.done = decoder.decodeBool(forKey: "done")
    }
    
    func encode(with coder: NSCoder) {
        
        if self.identifier != nil {
            coder.encode(String(self.identifier ?? 0), forKey: "identifier")
        }
        coder.encode(title, forKey: "title")
        coder.encode(message, forKey: "message")
        coder.encode(done, forKey: "done")
    }
}
