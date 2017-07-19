//
//  ViewController.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 24/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {

    var taskDataSource: TaskTableViewDataSource?
    var taskInteractor = TaskInteractor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.title = "TO DO"
        self.addBarButtons()
        
        
        //automatic height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44

        
        taskDataSource = TaskTableViewDataSource(tableView: self.tableView,
                                                 dataSource: [],
                                                 updateTaskHandler: { [weak interactor = self.taskInteractor] (task) in
                                                    interactor?.updateTask(task)
        }, deleteTaskHandler: { [weak interactor = self.taskInteractor] (task) in
            interactor?.deleteTask(task)
        })
        
//        taskDataSource = TaskTableViewDataSource(tableView: self.tableView,
//                                                 dataSource: [],
//                                                 updateTaskHandler: { [weak interactor = self.taskInteractor] (task) in
//                                                    
//                                                    interactor?.updateTask(task)
//                                                    
//        }), deleteHandler: { (task) in
//            
//        })
        self.tableView.delegate = self
        
        taskInteractor.retrieveTasks { [unowned self] (tasks) in
            if let tasks = tasks {
                self.taskDataSource?.updateTasks(tasks)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    //MARK: - Table delegate methods
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var task = self.taskDataSource?.taskForRow(indexPath.row)
        if task != nil {
            let viewController = TaskDetailViewController(nibName: "TaskDetailViewController", bundle: nil, task: &task!)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    //MARK: - Helpers
    
    func addTask() {
        
        let alertController = UIAlertController(title: "Añadir nueva tarea", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "introduce una tarea"
        }
        
        let addAction = UIAlertAction(title: "añadir", style: .default) { [unowned self] (action) in
            alertController.dismiss(animated: true, completion: nil)
            
            if let taskTitle = alertController.textFields?.last?.text {
                
                let task = Task(title: taskTitle, message: nil)
                self.taskInteractor.addTask(task, successHandler: { [unowned self] (task) in
                    
                    DispatchQueue.main.async {
                            self.taskDataSource?.addTask(task)
                    }                    
                }, errorHandler: { (error) in
                    //TODO: show error
                })                
            }
        }
        
        let cancelAction = UIAlertAction(title: "cancelar", style: .cancel, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Styling navigation bar
    
    func addBarButtons() {
        
        let item = self.navigationItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                         target: self,
                                         action: #selector(TodoTableViewController.addTask))
        
        item.setRightBarButton(addButton, animated: true)
        self.updateEditableButton(editing: self.tableView.isEditing)
        
    }

    func makeTableEditable() {
        
        self.tableView.setEditing(!self.tableView.isEditing, animated: true)
        self.updateEditableButton(editing: self.tableView.isEditing)
    }
    
    func updateEditableButton(editing: Bool) {
        
        var barButton: UIBarButtonItem
        
        if editing {
            barButton = UIBarButtonItem(barButtonSystemItem: .done,
                                   target: self,
                                   action: #selector(TodoTableViewController.makeTableEditable))
            
        } else {
            barButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                                target: self,
                                                action: #selector(TodoTableViewController.makeTableEditable))
        }
        
        self.navigationItem.setLeftBarButton(barButton, animated: true)
    }

}

