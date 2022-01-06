//
//  CreateProfileViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/1/20.
//

import UIKit
import CoreLocation

class CreateProfileViewController: UIViewController {

    //outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var homeGymTextField: UITextField!
    @IBOutlet weak var sportTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    
    //variables
    var locationManger: CLLocationManager = CLLocationManager()
    var lat : Double!
    var long : Double!
    
    //override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //image methods call to add touch gesture
        self.profileImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        self.profileImageView.addGestureRecognizer(gestureRecognizer)
        
        
        //textfield delegates
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.sportTextField.delegate = self
        self.homeGymTextField.delegate = self
        
        //location methods
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        enableLocationServices()
        
        
    } // end of method viewdidload
    

   

} // end of class

extension CreateProfileViewController {
    
    @IBAction func createButtonPressed(_ sender: Any) {
        
        //profile viewmodel send to firebase method
        CreateProfileViewModel.instance.sendToFirebase(firstName: self.firstNameTextField.text!, lastName: self.lastNameTextField.text!, homeGym: self.homeGymTextField.text!, sport: self.sportTextField.text!, imageView: self.profileImageView, lattude: lat ?? 0.0, longitude: long ?? 0.0) { (success) in
            if success {
                self.performSegue(withIdentifier: "PlayerListVC", sender: nil)
            } else {
                AlertHelper.instance.errorAlert(titleInput: "Errror", messageInput: "There is an Error") { (alert) in
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    } // end of button function
    
}

extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    //images
    @objc func chooseImage() {
         let pickerController = UIImagePickerController()
         pickerController.delegate = self
         pickerController.sourceType = .photoLibrary
         present(pickerController, animated: true, completion: nil)
     }
     
     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         profileImageView.image = info[.originalImage] as? UIImage
         self.dismiss(animated: true, completion: nil)
         
     } // end of ImagePicker
    
    
    
    
    //text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.homeGymTextField.resignFirstResponder()
        self.firstNameTextField.resignFirstResponder()
        self.lastNameTextField.resignFirstResponder()
        self.sportTextField.resignFirstResponder()
           return true
       }
}

//location manager

extension CreateProfileViewController : CLLocationManagerDelegate {
    
    //location setup for corelocation method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //did update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last?.coordinate.latitude)
        self.lat = locations.last?.coordinate.latitude
        self.long = locations.last?.coordinate.longitude
        
        
        
    }
   
    
    // enable location services
    func enableLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            locationManger.startUpdatingLocation()
        }
    }
    
    
    
    //disable location services
    func disableLocationServices() {
        locationManger.stopUpdatingLocation()
    }
    
   
        
    
    

    
}
