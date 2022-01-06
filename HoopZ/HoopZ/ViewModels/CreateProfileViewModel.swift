//
//  CreateProfileViewModel.swift
//  HoopZ
//
//  Created by dadDev on 12/2/20.
//

import Foundation
import Firebase
import GeoFire
import CoreLocation


class CreateProfileViewModel {
    
    
    
    static let instance = CreateProfileViewModel()
    
    
    func sendToFirebase(firstName: String, lastName: String, homeGym: String, sport: String, imageView: UIImageView,lattude: Double, longitude: Double, completion: @escaping(_ succesfulL: Bool ) -> Void) {
        
        var currentUserEmail: String? = Auth.auth().currentUser?.email
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("userImages")
        
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
                                            "canPlay":   false,
                                            "sport" : sport,
                                            "location" : GeoPoint.init(latitude: lattude, longitude:  longitude),
                                            
                                              
                                          ] as [String : Any] // end of dictionary
                        fireStoreRef = fireStoreDB.collection("Users").addDocument(data: firestoreProfileData, completion: { (error) in
                            if error != nil {
                                completion(false)
                                
                            } else {
                                completion(true)
                            }
                            
                        })
                    }
                }
            }
        }
        
        
    }
}


