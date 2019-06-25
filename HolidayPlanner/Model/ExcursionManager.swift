//
//  ExcursionManager.swift
//  HolidayPlanner
//
//  Class that lets us save and restore a list of excursions selected by the user.
//
//  Created by Rory Prior on 17/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class ExcursionManager {
  
  var excursions : Array<Excursion>
  
  init() {
    excursions = Array()
    self.restore()
  }
  
  func filePath() -> String {
    
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    return "\(documentDirectory)/excursions.json"
  }
  
  func add(excursion: Excursion) {
    
    if excursions.contains(where: {$0.id() == excursion.id()}) == false {
      excursions.append(excursion)
      save()
    }
  }
  
  func clear() {
    excursions = Array.init()
    self.save()
  }
  
  /*
   * Save the excursions by converting them to a local JSON formatted file
   */
  func save() {
    
    do {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(excursions) {
        if let json = String(data: encoded, encoding: .utf8) {
          try json.write(toFile: self.filePath(), atomically: true, encoding: .utf8)
        }
      }
    }
    catch let error {
      print("Error saving excursions! \(error.localizedDescription)")
    }
  }
  
  /*
   * Restore the excursions from a local JSON formatted file
   */
  func restore() {
    
    if FileManager.default.fileExists(atPath: filePath()) {
    
      do {
        let decoder = JSONDecoder()
        if let data = try? Data.init(contentsOf: URL.init(fileURLWithPath: filePath())) {
          self.excursions = try decoder.decode(Array<Excursion>.self, from: data)
        }
      }
      catch let error {
        print("Error loading excursions! \(error.localizedDescription)")
      }
    }
  }
}
