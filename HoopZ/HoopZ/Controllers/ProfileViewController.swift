//
//  ProfileViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/2/20.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet var playNotPlaySwitch: UISwitch!
    @IBOutlet var homeCourtLabel: UILabel!
    
    var user: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        playNotPlaySwitch.setOn(ProfileViewModel.instance.mySwitch, animated: true)
        ProfileViewModel().userInfo(userName: usernameLabel, userImage: profileImageView, homeGym: homeCourtLabel)
       // ProfileViewModel.instance.updateFB()
        // Do any additional setup after loading the view.
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


extension ProfileViewController {
    
    
    @IBAction func playNotPlaySwitch(_ sender: UISwitch) {
       
        ProfileViewModel.instance.updateAvailableSwitch(availableSwitch: self.playNotPlaySwitch)
    }
    
    @IBAction func testButton(_ sender: Any) {
        
        //ProfileViewModel.instance.updateFB()
        performSegue(withIdentifier: "UpdateVC", sender: nil)
    }
    
    @IBAction func toPendingVCButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "PendingVC", sender: nil)
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        ProfileViewModel.instance.signout { (success) in
            if success {
                self.performSegue(withIdentifier: "LoginVC", sender: nil)
            } else {
                AlertHelper.instance.errorAlert(titleInput: "Error", messageInput: "Error Signing Out") { (alert) in
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
