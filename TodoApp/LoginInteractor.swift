//
//  LoginInteractor.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

struct LoginInteractor {
 
    func login(username: String, password: String, successHandler: @escaping () -> (), errorHandler: @escaping (Error) -> ()) {
        
        NetworkManager.shared.POST(urlString: NetworkConstants.LOGIN_OPERATION,
                                   params: ["username" : username, "password": password],
                                   successHandler: { (json) in
            
                                    if let user = User(dic: json as! [String : Any]) {
                                        Session.shared.user = user
                                        successHandler()

                                    } else {
                                        errorHandler(NetworkError.NotReceivedData)
                                    }
            
        }, errorHandler: errorHandler)
    }
    
    func signup(username: String, password: String, email: String?, successHandler: @escaping () -> (), errorHandler: @escaping (Error) -> ()) {
        
        NetworkManager.shared.POST(urlString: NetworkConstants.SIGNUP_OPERATION,
                                   params: ["username" : username, "password": password, "email": email ?? ""],
                                   successHandler: { (json) in
                                    
                                    if let user = User(dic: json as! [String : Any]) {
                                        Session.shared.user = user
                                        successHandler()
                                        
                                    } else {
                                        errorHandler(NetworkError.NotReceivedData)
                                    }
            
        }, errorHandler: errorHandler)
    }
}
