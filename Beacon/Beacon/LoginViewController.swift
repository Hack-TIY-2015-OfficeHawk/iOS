//
//  LoginViewController.swift
//  SwiftyAlert
//
//  Created by Mac Bellingrath on 11/13/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    //Form Entry Text Fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    //MARK: - TextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTextField {
            userNameTextField.becomeFirstResponder()
        } else if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        
        return true
    }
    
    

    
    
    
    

    @IBAction func didPressCreateAccountButton(sender: AnyObject) {
        guard let teamName = nameTextField.text, let userName = userNameTextField.text, let password = passwordTextField.text else { return }
        
        NetworkManager.sharedManager().register(teamName, un: userName, pw: password) { (success) -> () in
    
            if success {
                SweetAlert().showAlert("Success!", subTitle: "We're glad you're here.", style: AlertStyle.Success, buttonTitle: "Get Started") { (isOtherButton) -> Void in
                   
                    self.presentMainFlow()
                }
            }
        }
    }
}
