//
//  ExcursionChecker.swift
//  Jet2Test
//
//  Fetches excursions for the specified destination and date (this is all mocked up as no such API exists for the purposes of this test)
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class ExcursionChecker {
  
  
  func fetchExcursions(destination: String, date: Date, completion:@escaping (_ days : Array<Excursion>?, _ error: Error?) -> Void) {
    
    // the mocked up data will be the same for every destination and date so we ignore these parameters
    
    if let excursionJSONURL = Bundle.main.url(forResource: "excursions", withExtension: "json"),
       let data = try? Data.init(contentsOf: excursionJSONURL) {
    
      let json = try? JSONSerialization.jsonObject(with: data, options: [])
    
      var excursions = Array.init() as Array<Excursion>
      
      if let root = json as? [String: Any],
         let items = root["items"] as? Array<[String : Any]> {
      
          for item in items {
            
            if let name = item["name"] as? String,
               let description = item["description"] as? String,
               let price = (item["price"] as? NSNumber)?.doubleValue,
               let image = item["image"] as? String {
            
              let excursion = Excursion.init(destinationName: destination, name: name, description: description, price: price, image: image)
              excursions.append(excursion)
          }
        }
        completion(excursions, nil)
      }
    }
    else {
      let error = NSError(code: 404, message: "Unable to open excursion data")
      completion(nil, error)
    }
  }
}
