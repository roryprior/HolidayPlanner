//
//  ExcursionManager.swift
//  HolidayPlanner
//
//  Class that lets us save and restore a list of excursions selected by the user.
//  This is a fairly quick and dirty solution due to time constraints
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
    return "\(documentDirectory)/excursions.plist"
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
   * Save the excursions by converting them to NSDictionaries which be stored as a plist file
   */
  func save() {
    
    let saveArray = NSMutableArray.init()
    
    for excursion in excursions {
      
      let dictionary = NSMutableDictionary.init()
      dictionary.setObject(excursion.name as NSString, forKey: "name" as NSString)
      dictionary.setObject(excursion.description as NSString, forKey: "description" as NSString)
      dictionary.setObject(excursion.destinationName as NSString, forKey: "destination" as NSString)
      dictionary.setObject(excursion.image as NSString, forKey: "image" as NSString)
      dictionary.setObject(NSNumber.init(value: excursion.price), forKey: "price" as NSString)
      
      saveArray.add(dictionary)
    }
    
    saveArray.write(toFile: filePath(), atomically: true)
  }
  
  /*
   * Restore the excursions from a plist file
   */
  func restore() {
    
    if FileManager.default.fileExists(atPath: filePath()) {
    
      if let restoreArray = NSArray.init(contentsOfFile: filePath()) {
      
        excursions = Array.init()
        
        for case let dictionary as NSDictionary in restoreArray {
          
          excursions.append(Excursion.init(destinationName: dictionary.object(forKey: "destination") as! String,
                                           name: dictionary.object(forKey: "name") as! String,
                                           description: dictionary.object(forKey: "description") as! String,
                                           price: (dictionary.object(forKey: "price") as! NSNumber).doubleValue,
                                           image: dictionary.object(forKey: "image") as! String))
        }
      }
    }
  }
}
