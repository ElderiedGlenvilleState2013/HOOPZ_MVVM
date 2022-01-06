//
//  UserLocation.swift
//  HoopZ
//
//  Created by dadDev on 12/2/20.
//

import Foundation

struct UserLocation : Codable{
    var email: String
    var lat: Double
    var long: Double
    
    
    enum CodingKeys: String, CodingKey {
        case email
        case lat
        case long 
    }
}
