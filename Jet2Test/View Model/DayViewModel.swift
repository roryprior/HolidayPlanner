//
//  DayViewModel.swift
//  Jet2Test
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class DayViewModel {
  
  private var day : Day?
  
  
  
  init(with aDay: Day) {
    day = aDay
  }
  
  func highTemp() -> String {
    guard day != nil else {
      return "--ºC"
    }
    return String(format: "%.1fºC", day!.highTemp)
  }
  
  func lowTemp() -> String {
    guard day != nil else {
      return "--ºC"
    }
    return String(format: "%.1fºC", day!.lowTemp)
  }
  
  func weatherDescription() -> String {
    
    guard day != nil else {
      return "..."
    }
    
    return day?.description ?? "..."
  }
  
  func weatherIcon() -> UIImage? {
    
    guard let iconName = day?.icon else {
      return UIImage.init(named: "01d")
    }
    
    return UIImage.init(named: iconName)
  }
  
  func dayOfMonth() -> String {
    
    let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
    
    guard let date = day?.date else {
      return "--"
    }
    return String(format: "%d", calendar.dateComponents([.day], from: date).day ?? 0)
  }
  
  func monthName() -> String {
    
    guard let date = day?.date else {
      return "---"
    }
    
    let formatter = DateFormatter()
    formatter.locale = Locale.init(identifier: "en_GB")
    formatter.setLocalizedDateFormatFromTemplate("MMM")
    
    return formatter.string(from: date)
  }
}
