//
//  LoginViewController.swift
//  TodoApp
//
//  Created by Borja Igartua Pastor on 18/7/17.
//  Copyright © 2017 Borja Igartua Pastor. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    var loginInteractor = LoginInteractor()
    weak var showingAlert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func loginButtonPressed() {
        
        let alertController = UIAlertController(title: "Login", message: "Intro your data to log in", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "username"
            textField.delegate = self
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "password"
            textField.delegate = self
            textField.isSecureTextEntry = true
        }
        
        let addAction = UIAlertAction(title: "Login", style: .default) { [unowned self] (action) in
            
            if let username = alertController.textFields?[0].text, username.length > 0 {
                if let password = alertController.textFields?[1].text, password.length > 0 {
                    self.showingAlert = nil
                    self.loginInteractor.login(username: username,
                                               password: password,
                                               successHandler: {
                                                
                                                DispatchQueue.main.async {
                                                
                                                    if let window = UIApplication.shared.keyWindow {
                                                        let navController = self.storyboard?.instantiateViewController(withIdentifier: "tasksNavigationController");
                                                        
                                                        UIView.transition(with: window,
                                                                          duration: 0.4,
                                                                          options: .transitionFlipFromLeft,
                                                                          animations: { [weak window] in
                                                                            
                                                                            window?.rootViewController = navController
                                                                            
                                                        }, completion: nil)
                                                    }
                                                }
                        
                    }, errorHandler: { (error) in
                        //TODO: show error
                        print(error)
                    })
                }
            }
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { [unowned self] (action) in
            self.showingAlert = nil
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        showingAlert = alertController
        
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func signupButtonPressed() {
        
        let alertController = UIAlertController(title: "Signup", message: "Intro your data to sign up", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "username"
            textField.delegate = self
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "password"
            textField.delegate = self
            textField.isSecureTextEntry = true
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "email"
            textField.delegate = self
        }
        
        let addAction = UIAlertAction(title: "Signup", style: .default) { [unowned self] (action) in
            
            if let username = alertController.textFields?[0].text, username.length > 0 {
                if let password = alertController.textFields?[1].text, password.length > 0 {
                    
                    self.showingAlert = nil
                    let email = alertController.textFields?[2].text
                    self.loginInteractor.signup(username: username,
                                                password: password,
                                                email: email,
                                                successHandler: {
                                                    
                                                    DispatchQueue.main.async {
                                                        
                                                        if let window = UIApplication.shared.keyWindow {
                                                            let navController = self.storyboard?.instantiateViewController(withIdentifier: "tasksNavigationController");
                                                            
                                                            UIView.transition(with: window,
                                                                              duration: 0.4,
                                                                              options: .transitionFlipFromLeft,
                                                                              animations: { [weak window] in
                                                                                
                                                                                window?.rootViewController = navController
                                                                                
                                                                }, completion: nil)
                                                        }
                                                        
                                                    }
                    }, errorHandler: { (error) in
                        print(error)
                    })
                }
            }
        }
        
        addAction.isEnabled = false
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { [unowned self] (action) in
            self.showingAlert = nil
        }
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        showingAlert = alertController
        
        self.present(alertController, animated: true, completion: nil)
    }
    
//MARK: - UITextfield delegate
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {
        
        var usernameText = showingAlert?.textFields?[0].text
        var passwordText = showingAlert?.textFields?[1].text
        
        if let actualText = (textField.text as NSString?) {
            let completeText = actualText.replacingCharacters(in: range, with: string)
            if textField == showingAlert?.textFields?[0] {
                usernameText = completeText
            } else if textField == showingAlert?.textFields?[1] {
                passwordText = completeText
            }
        }
        
        if (usernameText?.length ?? 0) > 0 && (passwordText?.length ?? 0) > 0 {
            showingAlert?.actions[0].isEnabled = true
            
        } else {
            showingAlert?.actions[0].isEnabled = false
        }
        
        return true
    }
}
