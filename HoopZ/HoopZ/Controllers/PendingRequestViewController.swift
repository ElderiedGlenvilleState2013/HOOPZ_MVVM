//
//  PendingRequestViewController.swift
//  HoopZ
//
//  Created by dadDev on 12/15/20.
//

import UIKit

class PendingRequestViewController: UIViewController , UINavigationControllerDelegate{

    var names = ["nkn", "LLOP", "uoupp","sffs"]
    @IBOutlet var tableView: UITableView!
    
    var requestAndPendingVM: RequestAndPendingViewModel = RequestAndPendingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.requestAndPendingVM.getPlayerRequest(tableView: self.tableView)
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // end of class


//MARK: - tableview area 
extension PendingRequestViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //return self.requestAndPendingVM.playerRequests.count
        return RequestAndPendingViewModel.instance.playerRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as? PendingRequestTableViewCell
        
        
        //cell?.nameLabel.text = self.requestAndPendingVM.playerRequests[indexPath.row].sender
        
        cell?.nameLabel.text = RequestAndPendingViewModel.instance.playerRequests[indexPath.row].sender
        
        
        return cell!
    }
    
    
    
}
