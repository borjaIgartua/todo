//
//  TaskDetailViewController.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 26/5/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var statusSwitch: UISwitch!
    
    @IBOutlet weak var safeButton: UIButton!
    
    var taskDetailInteractor: TaskDetailInteractor
    
    var task: Task?
    var editingTask = false
    
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, task: inout Task) {
        self.task = task
        self.taskDetailInteractor = TaskDetailInteractor()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.taskDetailInteractor = TaskDetailInteractor()
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateEditableButton(editing: editingTask)
        
        self.titleLabel.text = task?.title
        self.messageLabel.text = task?.message
        self.statusLabel.text = (task?.done ?? false) ? "Tarea realizada" : "Por hacer"
        
    }
    
    func updateEditableButton(editing: Bool) {
        
        var barButton: UIBarButtonItem
        
        if editing {
            barButton = UIBarButtonItem(barButtonSystemItem: .done,
                                        target: self,
                                        action: #selector(TaskDetailViewController.makeTaskEditable))
            
        } else {
            barButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                        target: self,
                                        action: #selector(TaskDetailViewController.makeTaskEditable))
        }
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    func makeTaskEditable() {
        
        self.editingTask = !editingTask
        self.updateEditableButton(editing: editingTask)
        
        UIView.animate(withDuration: 0.5) {
            
            if self.editingTask {
                
                self.titleTextField.text = self.task?.title
                self.messageTextField.text = self.task?.message
                self.statusSwitch.setOn((self.task?.done ?? false), animated: true)
                
                self.titleLabel.alpha = 0.0
                self.messageLabel.alpha = 0.0
                
                self.titleTextField.alpha = 1.0
                self.messageTextField.alpha = 1.0
                self.statusSwitch.alpha = 1.0
                self.safeButton.alpha = 1.0
                
            } else {
                
                self.titleLabel.alpha = 1.0
                self.messageLabel.alpha = 1.0
                
                self.titleTextField.alpha = 0.0
                self.messageTextField.alpha = 0.0
                self.statusSwitch.alpha = 0.0
                self.safeButton.alpha = 0.0
            }
        }
    }
    
    @IBAction func safeButtonPressed(_ sender: UIButton) {
        
        if let taskTitle = titleTextField.text {
            
            task?.title = taskTitle
            task?.message = messageTextField.text
            task?.done = statusSwitch.isOn
            
            self.titleLabel.text = task?.title
            self.messageLabel.text = task?.message
            self.statusLabel.text = (task?.done ?? false) ? "Tarea realizada" : "Por hacer"
            
            self.makeTaskEditable()
            
            taskDetailInteractor.updateTask(task)
            
        } else {
            //TODO: show error no task without title
        }
        
    }
    
    @IBAction func statusSwichChanged(_ sender: Any) {
        
        task?.done = statusSwitch.isOn
        self.statusLabel.text = (task?.done ?? false) ? "Tarea realizada" : "Por hacer"
    }
}
