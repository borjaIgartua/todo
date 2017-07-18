//
//  NetworkConstants.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    static let SIGNUP_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "signup" : "http://192.168.0.195:8080/signup"
    static let LOGIN_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "login" : "http://192.168.0.195:8080/login"
    
    
    static let TASKS_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "tasks" : "http://192.168.0.195:8080/tasks"
    static let REGISTER_TASKS_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "register" : "http://192.168.0.195:8080/tasks/register"
    static let UPDATE_TASKS_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "update" : "http://192.168.0.195:8080/tasks"
    static let DELETE_TASKS_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "delete" : "http://192.168.0.195:8080/tasks"
}
