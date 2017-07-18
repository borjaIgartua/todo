//
//  NetworkConstants.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation

struct NetworkConstants {
    
    static let TASKS_OPERATION = AppConfiguration.SIMULATE_HTTP_CONEXIONS ? "tasks" : "http://demo1538413.mockable.io/tasks"
}
