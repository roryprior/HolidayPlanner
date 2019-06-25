//
//  ExcursionChecker.swift
//  HolidayPlanner
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
    
    if let excursionJSONURL = Bundle.main.url(forResource: "excursions", withExtension: "json") {
      
      do {
        if let data = try? Data.init(contentsOf: excursionJSONURL) {
          let decoder = JSONDecoder()
          var excursions = try decoder.decode(Array<Excursion>.self, from: data)
          
          // this is a little hack because we're not getting real data from a server and instead are reusing the same
          // json snippet for each destination, this simply sets the destination name in the excursion structs so we can
          // give the impression the data is unique to that location.
          for index in 0..<excursions.count {
            excursions[index].destinationName = destination
          }
          
           completion(excursions, nil)
        }
        else {
          let error = NSError(code: 404, message: "Unable to open excursion data")
          completion(nil, error)
        }
      }
      catch let error {
        print("Error fetching excursions \(error.localizedDescription)")
        completion(nil, error)
      }
    }
    else {
      let error = NSError(code: 404, message: "Unable to open excursion data")
      completion(nil, error)
    }
  }
}
