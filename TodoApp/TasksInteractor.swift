//
//  TasksInteractor.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import DispatchIntrospection
import Foundation

class TaskInteractor {
    
    typealias UpdateClosure = ([Task]?) -> ()
    var updateHandler: UpdateClosure?
    var tasks: [Task]?
    
    init() {
        
        /*
         
         //To Post a notification
         NotificationCenter.default.post(name: notificationName, object: nil)
         
         extension Notification.Name {
            static let yourCustomNotificationName = Notification.Name("yourCustomNotificationName")
         }
        
         */
        
        NotificationCenter.default.addObserver(self, selector: #selector(TaskInteractor.storeTaskInPersistance),
                                               name: Notification.Name.UIApplicationWillResignActive,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIApplicationWillResignActive, object: nil);
    }
    
    func retrieveTasks(updateHandler: @escaping UpdateClosure) {
        
        self.updateHandler = updateHandler
        self.getTasksFromServer()
        self.updateHandler?(getTaskFromPersistence())
        
    }
    
    func updateTask(_ task: Task) {
        
        NetworkManager.shared.PUT(urlString: NetworkConstants.UPDATE_TASKS_OPERATION,
                                  params: task.params,
                                  successHandler: nil) { (error) in
            //TODO: undone the task
        }
    }
    
    func deleteTask(_ task: Task) {
        
        if let identifier = task.identifier {
            NetworkManager.shared.DELETE(urlString: (NetworkConstants.DELETE_TASKS_OPERATION + "/" + String(identifier)),
                                         params: [:],
                                         successHandler: nil) { (error) in
                //TODO: undone delete task and show error
            }
        }
    }
    
    func addTask(_ task: Task, successHandler: @escaping (Task) -> (), errorHandler: @escaping (Error) -> ()) {
        
        NetworkManager.shared.POST(urlString: NetworkConstants.REGISTER_TASKS_OPERATION,
                                   params:task.params,
                                   successHandler: { (json) in
                                    
                                    if let dic = json as? [String: Any], let task = Task(dic) {
                                        successHandler(task);
                                        
                                    } else {
                                        errorHandler(NetworkError.NotReceivedData)
                                    }
        }, errorHandler: errorHandler)
    }
    
    private func getTaskFromPersistence() -> [Task]? {
        
        guard let data = UserDefaults.standard.data(forKey: "tasks_key") else {
            return nil
        }
        
        let tasks = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Task]
        return tasks
    }
    
    private func getTasksFromServer() {
        
        NetworkManager.shared.GET(urlString: NetworkConstants.TASKS_OPERATION,
                           successHandler: { (json) in
                            
                            if let dic = json as? [Any] {
                                let tasks = dic.map({ (taskDic) -> Task? in
                                    return Task(taskDic as! [String: Any])
                                })
                                
                                DispatchQueue.main.async {
                                    self.updateHandler?(tasks as? [Task])
                                }
                                
                                self.safeTaskInPersistance(tasks: tasks as? [Task])
                            }
            
        }) { (error) in
            print(error)
             //TODO: show error
        }

    }
    
    private func safeTaskInPersistance(tasks: [Task]?) {
        
        if let tasks = tasks, tasks.count > 0 {
                        
            let data = NSKeyedArchiver.archivedData(withRootObject: tasks)
            UserDefaults.standard.setValue(data, forKey: "tasks_key")
            UserDefaults.standard.synchronize()
        }
    }
    
    @objc private func storeTaskInPersistance() {
        self.safeTaskInPersistance(tasks: self.tasks)
    }
}
