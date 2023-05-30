//
//  Product.swift
//  Alamofire-In-FirstTimes
//
//  Created by Mac on 27/05/23.
//

import Foundation

struct Product:Codable {
    var result:[Result]
}

struct Result:Codable {
    var genericName:String
    var productId:String
    var mrpPrice:Int
    var sellPrice:Int
    var defaultImage:String
    var description:String
}
