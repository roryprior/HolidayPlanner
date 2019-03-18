//
//  Day.swift
//  Jet2Test
//
//  Represents a day with average weather conditions and any excursions
//
//  Created by Rory Prior on 13/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Day {
  
  var date : Date?
  var icon : String?
  var description : String?
  var highTemp : Float
  var lowTemp : Float
  var excursions : Array<Excursion>?
  
  init() {
    date = nil
    icon = nil
    description = nil
    highTemp = -100
    lowTemp = 100
    excursions = Array.init()
  }
  
  var debugDescription: String {
    return "\(date ?? Date.init()) icon code: \(icon ?? "nil") description: \(description ?? "nil") H:\(highTemp)ºC L:\(lowTemp)ºC excursions: \(String(describing: excursions))"
  }
  
}
