//
//  SignInViewController.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
  
    @IBAction func useTouchIDButtonPressed(sender: AnyObject) {
        
        
        useTouchID("Please authenticate to view coworker locations") { [weak self] (success, messageState, errorResult) -> Void in
            
            if success {
               dispatch_async(dispatch_get_main_queue()
                , { () -> Void in
                     self?.presentMainFlow()
               })
            }
            print(messageState)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func userDidPressLoginButton(sender: AnyObject) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text  else { return }
        
        NetworkManager.sharedManager().login(username, pw: password) { (success) -> () in
            
            if success {
                //show success
                SweetAlert().showAlert("Success", subTitle: "You are now logged in", style: AlertStyle.Success)
                
                self.presentMainFlow()
                
            } else if !success {
                
                SweetAlert().showAlert("Login Failed", subTitle: "Please try again.", style: AlertStyle.Warning, buttonTitle: "OK")
                
            }
            
        }
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

}
