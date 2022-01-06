//
//  UpdateProfileViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/5/20.
//

import Foundation
import Firebase
import SDWebImage
import UIKit


class UpdateProfileViewController: UIViewController {
    
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var homeGymTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
       
        self.imageView.addGestureRecognizer(gesturRecognizer)
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        homeGymTextField.delegate = self
        
        ProfileViewModel.instance.getPlaceholderInfo(firstnamePlaceholder: firstNameTextField, lastnamePlaceholder: lastNameTextField, gymPlaceholder: homeGymTextField)
        
       

        
    } // end of func
    
}


//extension for Firebase

extension UpdateProfileViewController {
    
    @IBAction func updateButtonPressed(_ sender: Any) {
        ProfileViewModel.instance.updateFB(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, homeGym: self.homeGymTextField.text!, imageView: self.imageView) { (success) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                AlertHelper.instance.errorAlert(titleInput: "error", messageInput: "error") { (alert) in
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
} // end of extension


extension UpdateProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    //images
    @objc func chooseImage() {
         let pickerController = UIImagePickerController()
         pickerController.delegate = self
         pickerController.sourceType = .photoLibrary
         present(pickerController, animated: true, completion: nil)
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         imageView.image = info[.originalImage] as? UIImage
         self.dismiss(animated: true, completion: nil)
         
     } // end of ImagePicker
    
    
    
    
    //text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.homeGymTextField.resignFirstResponder()
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.homeGymTextField.resignFirstResponder()
           return true
       }
}

