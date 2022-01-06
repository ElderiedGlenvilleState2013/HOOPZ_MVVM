//
//  AlertHelper.swift
//  HoopZ
//
//  Created by dadDev on 12/2/20.
//

import Foundation
import Firebase

class AlertHelper {
    
    
    static let instance = AlertHelper()
    
    func makeLoginAlert(titleInput: String, messageInput: String, emailTextField: UITextField, passwordTextField: UITextField, complettion: @escaping(_ alertController: UIAlertController) -> Void ) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        passwordTextField.backgroundColor = UIColor.red
        emailTextField.backgroundColor = UIColor.red
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        //present(alert, animated: true, completion: nil)
        complettion(alert)
        
    }
    
    func errorAlert(titleInput: String, messageInput: String, newAlertController: @escaping(_ alertController: UIAlertController) -> Void) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        
        newAlertController(alert)
    }
}
