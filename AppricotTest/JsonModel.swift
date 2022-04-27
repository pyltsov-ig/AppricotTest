//
//  JsonModel.swift
//  AppricotTest
//
//  Created by Igor Pyltsov on 26.04.2022.
//

import Foundation

class Character:Codable {
    
    var info:Info?
    var results:[Result]?
    
}

class Info:Codable {
    var count:Int?
    var pages:Int?
    var next:String?
    var prev:String?
}

class Result:Codable {
    var id:Int?
    var name:String?
    var status:String?
    var species:String?
    var gender:String?
    var location:Location?
    var image:String?
    var episode:[String]?
    
}

class Location:Codable {
    var name:String?
}

