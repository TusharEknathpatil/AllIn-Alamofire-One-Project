//
//  Otp.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 29/05/23.
//

import Foundation

struct Otp:Codable {
    
    var result:Results
}

struct Results:Codable {
    var mobile:String
    var otp:String
}
