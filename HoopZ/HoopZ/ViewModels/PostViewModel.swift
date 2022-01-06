//
//  PostViewModel.swift
//  HoopZ
//
//  Created by dadDev on 12/1/20.
//

import Foundation
import Firebase
import GeoFire
import CoreLocation
import MapKit
import SDWebImage

class PostViewModel  {
    static var instance = PostViewModel()
    
    
    var userArray = [User]()
    var testLocations : [TestLocation] = [TestLocation]()
    
    
    func geoQuery(tableView: UITableView) -> [User] {
        let geofireRef = Database.database().reference()
        let geoFire = GeoFire(firebaseRef: geofireRef)
        var user : User?
        var userArry = [User]()
        var fname : String = ""
        var lname : String = ""
        var hgym: String = ""
        var cPlay : Bool = false
        var url : String = ""
        var userEmail: String = ""
        var _testLocation : TestLocation?
        
        var playerTableView = PlayersListViewController().playerListTableView
        
        let center = CLLocation(latitude: 37.7832889, longitude: -122.4056973)
        // Query locations at [37.7832889, -122.4056973] with a radius of 600 meters
        var circleQuery = geoFire.query(at: center, withRadius: 0.6)

        let fireStoreDB = Firestore.firestore()
        
        fireStoreDB.collection("Users").order(by: "lastName").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription.description ?? "Error")
            } else {
                //userArry.removeAll(keepingCapacity: true)
                
                for document in snapshot!.documents {
                    
                    if let location = document.get("location") as? CLLocation {
                        let newCenter = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                        var cQuery = geoFire.query(at: newCenter, withRadius: 15)
                        
                    }
                    
                    if let firstnames = document.get("firstName") as? String {
                        fname = firstnames
                        //print("Goku :  \(fname)")
                    }
                    
                    
                    if let lastnames = document.get("lastName") as? String {
                        lname = lastnames
                    }
                    
                    if let gyms = document.get("homeGym") as? String {
                        hgym = gyms
                    }
                    
                    if let imageurl = document.get("imageUrl") as? String {
                        url = imageurl
                    }
                    
                    if let available = document.get("canPlay") as? Bool {
                        cPlay = available
                    }
                    
                    if let email = document.get("currentUserEmail") as? String {
                        userEmail = email
                    }
                    
                    user = User(firstName: fname, lastName: lname, email: userEmail, sport: "basketball", canPlayBall: cPlay, imageUrl: url, homeGym: hgym)
                   // print("Vegeta: \(user?.firstName), \(userArry.count)")
                    
                    userArry.append(user!)
                    
                    
                    playerTableView?.reloadData()
                    print(userArry)
                } // end of for loop
                
            }
            //tableView.reloadData()
        }
        
      
        //print(userArry.count)
        return userArry
    }
    

    
} // end class



extension PostViewModel {
    
    func getTableView(tableView: UITableView) {
        var user: User!
        var fname : String = ""
        var lname : String = ""
        var hgym: String = ""
        var cPlay : Bool = false
        var url : String = ""
        var userEmail : String = ""
        var location : CLLocation?
        var _testLocation : TestLocation?
        
        var playerTableView = PlayersListViewController().playerListTableView
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Users").order(by: "location").addSnapshotListener { [self] (snapshots, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshots?.isEmpty != true && snapshots != nil {
                    self.userArray.removeAll(keepingCapacity: true)
                    for document in snapshots!.documents {
                        if let firstname = document.get("firstName")  as? String {
                           fname = firstname
                           // self.r.nameOfUser = postedBy
                            
                        }
                        
                        if let lastname = document.get("lastName") as? String {
                            lname = lastname
                          
                        }
                       
                        if let homegym = document.get("homeGym") as? String{
                            //self.nameArray.append(names)
                           hgym = homegym
                            
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            
                            url = imageUrl
                        }
                     
                     if let  canplay = document.get("canPlay") as? Bool {
                         cPlay = canplay
                     }
                        
                        if let email = document.get("currentUserEmail") as? String {
                            userEmail = email
                        }
                        
                        if let locations = document.get("location") as? CLLocation {
                            location = locations
                        }
                        
                        user = User(firstName: fname, lastName: lname, email: userEmail, sport: "basketball", canPlayBall: cPlay, imageUrl: url, homeGym: hgym)
                       
                       
                        self.userArray.append(user)
                        
                        //self.userArray.filter((location?.distance(from: location!))!)
                        print(self.userArray.count)
                        
                        DispatchQueue.main.async {
                            playerTableView?.reloadData()
                            tableView.reloadData()
                        }
                    }
                    
                }
            }
        }
                   
                  
    }
    
    
    
   func  getLocationData() -> Void {
    var user: User!
    var fname : String = ""
    var lname : String = ""
    var hgym: String = ""
    var cPlay : Bool = false
    var url : String = ""
    var userEmail : String = ""
    var location : GeoPoint?
    var _testLocation : TestLocation?
    
    var playerTableView = PlayersListViewController().playerListTableView
    
    let firestoreDatabase = Firestore.firestore()
    
    firestoreDatabase.collection("Users").order(by: "location").addSnapshotListener { [self] (snapshots, error) in
        if error != nil {
            print(error?.localizedDescription)
        } else {
            if snapshots?.isEmpty != true && snapshots != nil {
                self.userArray.removeAll(keepingCapacity: true)
                for document in snapshots!.documents {
                    if let firstname = document.get("firstName")  as? String {
                       fname = firstname
                       // self.r.nameOfUser = postedBy
                        
                    }
                    
                    if let lastname = document.get("lastName") as? String {
                        lname = lastname
                      
                    }
                   
                    if let homegym = document.get("homeGym") as? String{
                        //self.nameArray.append(names)
                       hgym = homegym
                        
                    }
                    
                    if let imageUrl = document.get("imageUrl") as? String {
                        
                        url = imageUrl
                    }
                 
                 if let  canplay = document.get("canPlay") as? Bool {
                     cPlay = canplay
                 }
                    
                    if let email = document.get("currentUserEmail") as? String {
                        userEmail = email
                    }
                    
                    if let locations = document.get("location") as? GeoPoint {
                        location = locations
                        
                    }
                    
                    user = User(firstName: fname, lastName: lname, email: userEmail, sport: "basketball", canPlayBall: cPlay, imageUrl: url, homeGym: hgym)
                   
                    
                    self.userArray.append(user)
                    
                    //self.userArray.filter((location?.distance(from: location!))!)
                    print(self.userArray.count)
                    print(location?.latitude)
                    DispatchQueue.main.async {
                    _testLocation = TestLocation(lat: (location?.latitude)!, long: (location?.longitude)!, name: userEmail)
                    testLocations.append(_testLocation!)
                        print(testLocations[0].long)
                   }
                }
                
            }
        }
    }
    }
   
}
