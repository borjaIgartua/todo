//
//  File.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class NetworkAPI: NetworkClient {
    
    
    func GET(urlString: String,
             successHandler: @escaping SuccessHandler,
             errorHandler: @escaping ErrorHandler) {
        
        self.performRequestWithURLString(urlString: urlString,
                                         params: nil,
                                         httpHeaders: nil,
                                         httpMethod: "GET",
                                         successHandler: successHandler,
                                         errorHandler: errorHandler)
    }

    
    func POST(urlString: String,
                    params: [String: Any],
                    successHandler: @escaping SuccessHandler,
                    errorHandler: @escaping ErrorHandler) {
        
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        
        self.performRequestWithURLString(urlString: urlString,
                                         params: params,
                                         httpHeaders: headers,
                                         httpMethod: "POST",
                                         successHandler: successHandler,
                                         errorHandler: errorHandler)
    }
    
    
    private func performRequestWithURLString(urlString: String,
                                             params: [String: Any]?,
                                             httpHeaders: [String : String]?,
                                             httpMethod: String,
                                             successHandler: @escaping SuccessHandler,
                                             errorHandler: @escaping ErrorHandler) {
        
        guard let url = URL(string: urlString, params: params) else {
            errorHandler(NetworkError.URLMalformed)
            return
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5.0)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = httpHeaders
        
        if httpMethod == "POST" {
            guard let params = params, let requestObject = try? JSONSerialization.data(withJSONObject: params) else {
                return
            }
            request.httpBody = requestObject
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                errorHandler(error!)
                return
            }
            
            
            guard let data = data, data.count > 0 else {
                errorHandler(NetworkError.NotReceivedData)
                return
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
                
                print("Data received: \(String(data: data, encoding: String.Encoding.utf8) ?? "")")
                errorHandler(NetworkError.JSONMalformed)
                return
            }
            
            successHandler(json)
            
            }.resume()
    }
}
