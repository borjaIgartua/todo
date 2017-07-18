//
//  NetworkMock.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class NetworkMock: NetworkClient {
    
    func GET(urlString: String,
                    successHandler: SuccessHandler?,
                    errorHandler: ErrorHandler?) {
        
        self.readFile(urlString, successHandler: successHandler, errorHandler: errorHandler)        
    }
    
    func POST(urlString: String,
                     params: [String: Any],
                     successHandler: SuccessHandler?,
                     errorHandler: ErrorHandler?) {
        
        self.readFile(urlString, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func PUT(urlString: String,
              params: [String: Any],
              successHandler: SuccessHandler?,
              errorHandler: ErrorHandler?) {
        
        self.readFile(urlString, successHandler: successHandler, errorHandler: errorHandler)
    }
    
    
    func readFile(_ filename: String,
                  successHandler: SuccessHandler?,
                  errorHandler: ErrorHandler?) {
        
        var userInfo:[String:Any] = ["file": filename]
        userInfo["success"] = successHandler
        userInfo["failure"] = errorHandler
        
        let timer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(NetworkMock.readFileWithTimer(_:)),
                          userInfo: userInfo,
                          repeats: false)
        
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
    }
    
    @objc func readFileWithTimer(_ timer: Timer) {
        
        if let userInfo = timer.userInfo as? [String: Any] {
            
            let filename = userInfo["file"] as! String
            let successHandler = userInfo["success"] as? SuccessHandler
            let errorHandler = userInfo["failure"] as? ErrorHandler
            
            
            if let filePath = Bundle.main.path(forResource: filename, ofType: "json") {
                
                do {
                    let content = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
                    
                    if let contentData = content.data(using: String.Encoding.utf8) {
                        let responseObject = try JSONSerialization.jsonObject(with: contentData,
                                                                              options: JSONSerialization.ReadingOptions.mutableContainers)
                        
                        successHandler?(responseObject)
                        
                    } else {
                        throw NetworkError.JSONMalformed
                    }
                    
                } catch let error {
                    errorHandler?(error)
                }
            }
        }
        
        
    }
}
