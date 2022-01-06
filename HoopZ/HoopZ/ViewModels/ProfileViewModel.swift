//
//  ProfileViewModel.swift
//  HoopZ
//
//  Created by dadDev on 12/2/20.
//

import Foundation
import Firebase
import SDWebImage


class ProfileViewModel {
    
    static let instance = ProfileViewModel()
    
    var docId : String = ""
    
    var placeHolderFirstName: String = ""
    var placeHolderLastName: String = ""
    var placeHolderGymName: String = ""
    var mySwitch: Bool = false
    
    func getUserEmail(userEmail: String) -> String {
        return userEmail
    }
    var currentUserEmail = ""
    
    func signout(segue: @escaping(_  signedIn: Bool) -> ()) {

        do {
                                try Auth.auth().signOut()
                                segue(true)
                            } catch {
                                print(error)
                                segue(false)
                                                                
                                
                            }
    }
    
  
    
  
} // end of class



//MARK: - firebase get user

extension ProfileViewModel {
   
    
    func userInfo(userName: UILabel!, userImage: UIImageView!, homeGym: UILabel! ) {
        var firstName: String!
        var lastName: String!
        let fireStoreDB = Firestore.firestore()
        fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription.description ?? "Error")
            } else {
                for document in snapshot!.documents {
                    
                    if let firstname = document.get("firstName") as? String {
                        firstName = firstname
                        self.placeHolderFirstName = firstname
                    }
                    
                    if let lastname = document.get("lastName") as? String {
                        lastName = lastname
                        self.placeHolderLastName = lastname
                        print(self.placeHolderGymName)
                    }
                    
                    if let url = document.get("imageUrl") as? String {
                        userImage.sd_setImage(with: URL(string: url))
                    }
                    
                    if let gym = document.get("homeGym") as? String {
                        
                        homeGym.text = gym
                        self.placeHolderGymName = gym
                    }
                    
                    if let useremail = document.get("currentUserEmail") as? String {
                        self.currentUserEmail = self.getUserEmail(userEmail: useremail)
                        
                    }
                   // self.docId = document.documentID
                    //print("docid = \(self.docId) and \(document.documentID)")
                    userName.text = "\(firstName   ?? "firstname"), \(lastName ?? "lastname")"
                }
            }
        }
        
    } // end of function
    
    
    
    func getPlaceholderInfo(firstnamePlaceholder: UITextField!, lastnamePlaceholder: UITextField!, gymPlaceholder: UITextField!) {
        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription.description ?? "Error")
            } else {
                for document in snapshot!.documents {
                    
                    if let firstname = document.get("firstName") as? String {
                       
                        self.placeHolderFirstName = firstname
                        firstnamePlaceholder.placeholder = firstname
                    }
                    
                    if let lastname = document.get("lastName") as? String {
                        
                        //self.placeHolderLastName = lastname
                        lastnamePlaceholder.placeholder = lastname
                        print(" Hoolie :\(self.placeHolderGymName)")
                    }
                    
                  
                    
                    if let gym = document.get("homeGym") as? String {
                        
                        gymPlaceholder.placeholder = gym
                        self.placeHolderGymName = gym
                    }
                    
                    if let useremail = document.get("currentUserEmail") as? String {
                        self.currentUserEmail = self.getUserEmail(userEmail: useremail)
                        
                    }
                   // self.docId = document.documentID
                    //print("docid = \(self.docId) and \(document.documentID)")
                    //userName.text = "\(firstName   ?? "firstname"), \(lastName ?? "lastname")"
                }
            }
        }
        
    } // end of function
    
}


extension ProfileViewModel {
    
    func updateFB(firstName: String, lastName: String, homeGym: String, imageView: UIImageView, completion: @escaping(_ succesfulL: Bool ) -> Void) {
        let fireStoreDB = Firestore.firestore()
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("userImages")
        
        var currentUserEmail: String? = Auth.auth().currentUser?.email
        
       
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    completion(false)
                } else {
                    completion(true)
                
                    imageRef.downloadURL { (url, error) in
                        let imageUrl = url?.absoluteString
                                          
                                          let fireStoreDB = Firestore.firestore()
                                          var fireStoreRef : DocumentReference? = nil
                                          
                        
                                          let firestoreProfileData = [
                                            "currentUserEmail": Auth.auth().currentUser?.email,
                                            "firstName" :  firstName,
                                              "lastName" : lastName,
                                              "imageUrl" : imageUrl,
                                              "homeGym" :  homeGym,
                                            
                                            
                                              
                                          ] as [String : Any] // end of dictionary
                        fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
                            if error != nil {
                                print(error?.localizedDescription.description ?? "Error")
                            } else {
                                for document in snapshot!.documents {
                                    
                                    self.docId = document.documentID
                                    print("docid = \(self.docId) and \(document.documentID)")
                                    fireStoreDB.collection("Users").document(self.docId).updateData(firestoreProfileData) { (error) in
                                        
                                    }
                                }
                            }
                        }
                    }}}
                        
                    }
        
    } // end of function
    
    }


//MARK: - updating user availability with the switch 

extension ProfileViewModel {
    
    func updateAvailableSwitch(availableSwitch: UISwitch!) {
        let fireStoreDB = Firestore.firestore()
        availableSwitch.setOn(availableSwitch.isOn, animated: true)
        fireStoreDB.collection("Users").whereField("currentUserEmail", isEqualTo: Auth.auth().currentUser?.email).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription.description ?? "Error")
            } else {
                for document in snapshot!.documents {
                    
                    self.docId = document.documentID
                    print("docid = \(self.docId) and \(document.documentID)")
                    fireStoreDB.collection("Users").document(self.docId).updateData(["canPlay": availableSwitch.isOn]) { (error) in
                        if error == nil {
                            if availableSwitch.isOn {
                                DispatchQueue.main.async {
                                    self.mySwitch = true
                                    availableSwitch.setOn(true, animated: true)
                                }
                                
                                
                            } else {
                                DispatchQueue.main.async {
                                    self.mySwitch = false
                                    availableSwitch.setOn(false, animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    
    }
}
