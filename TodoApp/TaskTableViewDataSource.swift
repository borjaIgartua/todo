//
//  TaskTableViewDataSource.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class TaskTableViewDataSource: NSObject, UITableViewDataSource {
    unowned var tableView: UITableView
    var dataSource: [Task]
    
    typealias UpdateTaskHandler = (Task) -> ()
    var updateTaskHandler: UpdateTaskHandler?
    
    init(tableView: UITableView, dataSource: [Task], updateTaskHandler: UpdateTaskHandler? = nil) {
        self.tableView = tableView
        self.dataSource = dataSource
        self.updateTaskHandler = updateTaskHandler
        super.init()
        
        self.tableView.dataSource = self
        let nib = UINib(nibName: "TodoTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "taskCellIdentifier")
    }
    
    //MARK: - Helper methods
    
    func addTask(_ task: Task) {
        
        self.dataSource.append(task)
        let indexPath = IndexPath(row: self.dataSource.endIndex - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.left)
    }
    
    func updateTasks(_ tasks: [Task]) {
        
        self.dataSource = tasks
        self.tableView.reloadData()
    }
    
    func taskForRow(_ row: Int) -> Task {
        return self.dataSource[row]
    }
    
    //MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellIdentifier", for: indexPath) as! TodoTableViewCell
        cell.fillWithTitle(dataSource[indexPath.row].title, done: dataSource[indexPath.row].done) { [unowned self] (done) in
            self.dataSource[indexPath.row].done = done
            self.updateTaskHandler?(self.dataSource[indexPath.row])
        }
        return cell
    }
    
    //MARK: editing
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            self.dataSource.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        }
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let source = self.dataSource[sourceIndexPath.row]
        self.dataSource.remove(at: sourceIndexPath.row)
        self.dataSource.insert(source, at: destinationIndexPath.row)
    }
    
}
