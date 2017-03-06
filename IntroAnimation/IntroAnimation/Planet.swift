//
//  Planet.swift
//  IntroAnimation
//
//  Created by Ethan Hess on 2/5/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class Planet: NSObject {
    
    let kNameKey = "name"
    let kURLKey = "imageURL"
    let kDistanceKey = "distanceFromSun"
    
    let name : String?
    let imageURL : String?
    let distanceFromSun : String?
    
    init(dictionary: Dictionary<String, Any>) {
        
        if let name = dictionary[kNameKey] as? String {
            self.name = name
        }
        
        else {
            self.name = ""
        }
        
        if let imageURL = dictionary[kURLKey] as? String {
            self.imageURL = imageURL
        }
        
        else {
            self.imageURL = ""
        }
        
        if let distanceFromSun = dictionary[kDistanceKey] as? String {
            self.distanceFromSun = distanceFromSun
        }
        
        else {
            self.distanceFromSun = ""
        }
    }
}
