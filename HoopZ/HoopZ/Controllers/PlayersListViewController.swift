//
//  PlayersListViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/1/20.
//

import UIKit
import Firebase
import SDWebImage

class PlayersListViewController: UIViewController {

    @IBOutlet weak var playerListTableView : UITableView!
    

    var selectedUser : User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        playerListTableView.delegate = self
        playerListTableView.dataSource = self
        
       
        
        PostViewModel.instance.getTableView(tableView: self.playerListTableView)
        
        
    }
    


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let requestVC = segue.destination as? RequestViewController {
            requestVC.firstName = selectedUser?.firstName
            requestVC.lastName = selectedUser?.lastName
            requestVC.imageUrl = selectedUser?.imageUrl
            requestVC.useremail = selectedUser?.email
            requestVC.canPlay = selectedUser?.canPlayBall
        }
        
    }
   

} // end of class


//MARK: - TableView Section
extension PlayersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // num of cell per row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  PostViewModel.instance.userArray.count //geoQuery(tableView: playerListTableView).count
       //return usersArray.count
    }
    
    //cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerListTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)  as? PlayerListTableViewCell

        cell?.availableLabel.text = PostViewModel.instance.userArray[indexPath.row].canPlayBall == true ? "Available" : "Not Available"

        cell?.userNameLabel.text = "\(PostViewModel.instance.userArray[indexPath.row].firstName), \(PostViewModel.instance.userArray[indexPath.row].lastName)"

        cell?.homeGymLabel.text = PostViewModel.instance.userArray[indexPath.row].homeGym

        cell?.profileImageView.sd_setImage(with: URL(string: PostViewModel.instance.userArray[indexPath.row].imageUrl))
        

        return cell!
    }
    
     // height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    //select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = PostViewModel.instance.userArray[indexPath.row]
        performSegue(withIdentifier: "ShowRequestDetails", sender: nil)
    }
    
}
