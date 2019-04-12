//
//  Destination.swift
//  HolidayPlanner
//
//  Represents a city or island destination with n days of weather and excursions
//
//  Created by Rory Prior on 15/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

struct Destination {
  
  var name : String
  var code: String // country code helps to make sure we get accurate weather info but is not present for all destinations
  var days : Array<Day>

  init(name aName: String, code aCode: String, days dayArray: Array<Day>) {
    name = aName
    code = aCode
    days = dayArray
  }
  
}
