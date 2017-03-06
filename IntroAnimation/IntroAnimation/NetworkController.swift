//
//  NetworkController.swift
//  IntroAnimation
//
//  Created by Ethan Hess on 2/21/17.
//  Copyright © 2017 EthanHess. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    
    let BASE_URL = "http://localhost:6069"
    let URL_PLANETS = "/planets"
    
    static let sharedManager = NetworkController()
    
    func getPlanets(completion:@escaping (_ planetArray: [Planet]?) -> Void) {
    
        let url = URL(string: "\(BASE_URL)\(URL_PLANETS)")
        let session = URLSession.shared
        
        session.dataTask(with: url!) { (data, response, error) in
            
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            else {
                
                print("DATA \(data)")
                print("RESPONSE \(response)")
                
                let resultData = self.dataToJSON(data!)
                
                print("RESULT DATA \(resultData)")
                
                let resultDataArray = resultData as! [NSDictionary]
                
                print("RESULT DATA ARRAY \(resultDataArray)")
                
                var tempPlanetArray : [Planet] = []
                
                for dict in resultDataArray {
                    
                    let planet = Planet(dictionary: dict as! Dictionary<String, Any>)
                    tempPlanetArray.append(planet)
                }
                
                completion(tempPlanetArray)
            }
            
        }.resume()
        
    
    }
    
    func dataToJSON(_ data: Data) -> Any? {
        
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            
            print("ERROR \(myJSONError)")
        }
        return nil
    }
}
