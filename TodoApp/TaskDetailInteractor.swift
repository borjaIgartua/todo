//
//  TaskDetailInteractor.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import Foundation


struct TaskDetailInteractor {
    
    func updateTask(_ task: Task?) {
        
        if let task = task {
            NetworkManager.shared.PUT(urlString: NetworkConstants.UPDATE_TASKS_OPERATION,
                                      params: task.params,
                                      successHandler: { (json) in
                
            }) { (error) in
                
            }
        }
    }
}
