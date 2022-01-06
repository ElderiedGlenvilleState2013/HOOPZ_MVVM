//
//  RequestAndPendingViewModel.swift
//  HoopZ
//
//  Created by dadDev on 12/15/20.
//

import Foundation
import Firebase
import UIKit


class RequestAndPendingViewModel {
    
    static var instance = RequestAndPendingViewModel()
    var playerRequests: [PlayerRequest] = [PlayerRequest] ()
    
    func sendPlayRequest(playerRequest: PlayerRequest, completion: @escaping(Bool)-> Void) {
        
        
        let fireStoreDB = Firestore.firestore()
        var fireStoreRef : DocumentReference? = nil
        
        let firestoreProfileData = [
            "fromUser": playerRequest.sender,
            "toUser": playerRequest.receiver
            
            
        ] as [String : Any] // end of dictionary
        fireStoreRef = fireStoreDB.collection("Requests").addDocument(data: firestoreProfileData, completion: { (error) in
            if error != nil {
                completion(false)
                
            } else {
                completion(true)
                
                let firestoreProfileData = [
                    "pendingRequest" : FieldValue.arrayUnion([playerRequest.sender])
                    
                    
                    
                ] as [String : Any] // end of dictionary
                fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: playerRequest.receiver).addSnapshotListener { (snapshot, error) in
                    if error != nil {
                        print(error?.localizedDescription.description ?? "Error")
                    } else {
                        for document in snapshot!.documents {
                            
                            var docId: String = document.documentID
                            print("docid = \(docId) and \(document.documentID)")
                            fireStoreDB.collection("Users").document(docId).updateData(firestoreProfileData) { (error) in
                                
                            }
                        }
                    }
                }
            }
            
        })
    }
} // end of class


extension RequestAndPendingViewModel {
    
    
    //MARK: - Pending Request
    func getPlayerRequest(tableView: UITableView) {
        let fireStoreDB = Firestore.firestore()
        var fireStoreRef : DocumentReference? = nil
        var fromUser = ""
        
        fireStoreDB.collection("Requests").whereField("toUser", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshots, error) in
            if error != nil {
                print(error)
            } else {
               
                for document in snapshots!.documents {
                    if let user = document.get("fromUser") as? String {
                        fromUser = user
                    }
                } // end of For-loop
                
                fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: fromUser).addSnapshotListener { (snapShots, error) in
                    guard let documents = snapshots?.documents else {
                        return
                    }
                    self.playerRequests = documents.map({ (documentSnapshot) -> PlayerRequest in
                        let data = documentSnapshot.data()
                        let receiverUser = data["toUser"] as? String ?? ""
                        let senderUser = data["fromUser"] as? String ?? ""
                        
                        return PlayerRequest(sender: senderUser, receiver: receiverUser)
                    })
                    tableView.reloadData()
                    
                }
                
            }
        }
    }
}
