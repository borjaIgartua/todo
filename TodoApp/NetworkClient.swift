//
//  NetworkClient.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 27/6/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

typealias SuccessHandler = (Any) -> ()
typealias ErrorHandler = (Error) -> ()

enum NetworkError: Error {
    case URLMalformed
    case NotReceivedData
    case JSONMalformed
}

protocol NetworkClient {
    
    func GET(urlString: String,
             successHandler: @escaping SuccessHandler,
             errorHandler: @escaping ErrorHandler)
    
    func POST(urlString: String,
              params: [String: Any],
              successHandler: @escaping SuccessHandler,
              errorHandler: @escaping ErrorHandler)
}
