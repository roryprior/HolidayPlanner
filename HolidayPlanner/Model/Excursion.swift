//
//  Excursion.swift
//  HolidayPlanner
//
//  Represents an excursion
//
//  Created by Rory Prior on 15/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Excursion : Codable {
  
  var destinationName = "Somewhere"
  var name : String
  var description : String
  var price : Double // in pence
  var image : String
  
  // we don't want destinationName to be encoded with codable so we exclude its key
  private enum CodingKeys: String, CodingKey {
    case name
    case description
    case price
    case image
  }
  
  var debugDescription: String {
    return "Excursion: \(name) description: \(description) price: £\(String(format: "%.2f", price / 100)) image: \(image)"
  }
  
  // simple way of generating a unique ID for each excursion
  func id() -> String {
    return "\(destinationName)-\(name)"
  }
}
