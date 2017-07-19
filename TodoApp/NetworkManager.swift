//
//  NetworkManager.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let networkClient: NetworkClient
    
    static let shared = NetworkManager()
    
    private init() {
        
        if AppConfiguration.SIMULATE_HTTP_CONEXIONS {
            networkClient = NetworkMock()
            
        } else {
            networkClient = NetworkAPI()
        }
    }
    
    //MARK: - Utils
    
    func GET(urlString: String,
             successHandler: SuccessHandler?,
             errorHandler: ErrorHandler?) {
        
        self.networkClient.GET(urlString: urlString,
                               successHandler: successHandler,
                               errorHandler: errorHandler)
    }
    
    func POST(urlString: String,
              params: [String: Any],
              successHandler: SuccessHandler?,
              errorHandler: ErrorHandler?) {
     
        self.networkClient.POST(urlString: urlString,
                                params: params,
                                successHandler: successHandler,
                                errorHandler: errorHandler)
    }
    
    func PUT(urlString: String,
             params: [String: Any],
             successHandler: SuccessHandler?,
             errorHandler: ErrorHandler?) {
        
        self.networkClient.PUT(urlString: urlString,
                               params: params,
                               successHandler: successHandler,
                               errorHandler: errorHandler)
    }
    
    func DELETE(urlString: String,
                params: [String: Any],
                successHandler: SuccessHandler?,
                errorHandler: ErrorHandler?){
        
        self.networkClient.DELETE(urlString: urlString,
                                  params: params,
                                  successHandler: successHandler,
                                  errorHandler: errorHandler)
    }
}
