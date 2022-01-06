//
//  RequestViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/15/20.
//

import UIKit
import SDWebImage
import Firebase

class RequestViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var canPlayLabel: UILabel!
    
    var requestandPendingViewModel = RequestAndPendingViewModel()
    //from userModel
    var firstName: String?
    var lastName: String?
    var imageUrl: String?
    var canPlay: Bool?
    var useremail: String?
    //player model
    var playDetails : String = ""
    var playerRequest : PlayerRequest?
    
    
    func showUserDetails() {
         var FirstN = ""
        var LastN = ""
        if let fname = firstName {
            FirstN = fname
        }
        
        if let lname = lastName {
            LastN = lname
        }
        
        if let url = imageUrl {
            imageView.sd_setImage(with: URL(string: url))
        }
        
        if let playing = canPlay {
            
            self.playDetails = playing ? "Available" : "N/A"
            self.canPlayLabel.text = playDetails
        }
        
        nameLabel.text = "\(FirstN), \(LastN)"
        if let email = useremail {
            playerRequest = PlayerRequest(sender: (Auth.auth().currentUser?.email)!, receiver: email)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

                // Do any additional setup after loading the view.
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showUserDetails()
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} //end of Class


extension RequestViewController {
    
    @IBAction func sendRequestButtonPressed(_ sender: Any) {
        RequestAndPendingViewModel.instance.sendPlayRequest(playerRequest: playerRequest!) { (success) in
            if success {
                print("It is Good")
                self.performSegue(withIdentifier: "PlayerVC", sender: nil)
            } else {
                AlertHelper.instance.errorAlert(titleInput: "error", messageInput: "Something is wrong") { (alert) in
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
