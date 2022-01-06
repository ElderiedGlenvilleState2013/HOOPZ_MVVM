//
//  LoginViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/1/20.
//

import UIKit
import Firebase
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var emailTextField: UITextField!
       @IBOutlet weak var passwordTextField: UITextField!
    
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //textfield
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //location managers
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        enableLocationServices()
        
        
        // Do any additional setup after loading the view.
        
        print(locationManager.location?.coordinate.longitude)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController  {
   
    @IBAction func loginButtonPressed(_ sender: Any) {
        
//        setupCoreLocation()
//        enableLocationServices()
        LoginViewModel.instance.login(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (success, error) in
            if success {
                self.performSegue(withIdentifier: "PlayerListVC", sender: nil)
            } else {
                //self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription.description ?? "error")
                LoginViewModel.instance.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription.description ?? "Error", emailTextField: self.emailTextField, passwordTextField: self.passwordTextField) { (alert) in
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {

        LoginViewModel.instance.signup(email: self.emailTextField.text!, password: self.passwordTextField.text!) { (success, error) in
            
            if success {
                self.performSegue(withIdentifier: "CreateProfileVC", sender: nil)
            } else {
                LoginViewModel.instance.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription.description ?? "Error", emailTextField: self.emailTextField, passwordTextField: self.passwordTextField) { (alert) in
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    
    
}

//MARK: - CLL Location Manager
extension LoginViewController {

    // enable location services
    func enableLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }

    }




   

    //did update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last?.coordinate.latitude)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


extension LoginViewController: UITextFieldDelegate {
    
    
    //text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
           return true
       }
}
