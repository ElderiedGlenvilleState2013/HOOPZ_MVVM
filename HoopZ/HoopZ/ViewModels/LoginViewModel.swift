//
//  LoginViewModel.swift
//  HoopZ
//
//  Created by dadDev on 12/1/20.
//

import Foundation
import Firebase

class LoginViewModel {
    
    static let instance = LoginViewModel()
    
    func login(email: String, password: String , loginComplete: @escaping(_ status: Bool, _ error: Error?)-> ()) {
        if email != "" && email != "" {
            Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
                if error != nil {
                    // add alert
                    loginComplete(false, error)
                } else {
                    loginComplete(true, nil)
                    
                }
            }
        }
    }
    
    func signup(email: String, password: String, signupComplete: @escaping(_ status: Bool, _ error: Error?)-> ()) {
        if email != "" && password != "" {
            Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
                if error != nil {
                    signupComplete(false, error)
                } else {
                    signupComplete(true, nil)
                }
            }
        } 
    }
    
    
    
    
    func makeAlert(titleInput: String, messageInput: String, emailTextField: UITextField, passwordTextField: UITextField, complettion: @escaping(_ alertController: UIAlertController) -> Void ) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        passwordTextField.backgroundColor = UIColor.red
        emailTextField.backgroundColor = UIColor.red
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        //present(alert, animated: true, completion: nil)
        complettion(alert)
        
    }
}


