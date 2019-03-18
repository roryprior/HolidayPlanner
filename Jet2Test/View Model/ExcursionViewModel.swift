//
//  Excursion.swift
//  Jet2Test
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class ExcursionViewModel {
  
  var excursion : Excursion
  
  init(with anExcursion: Excursion) {
    self.excursion = anExcursion
  }
  
  func destinationName() -> String {
    
    return self.excursion.destinationName
  }
  
  func name() -> String {
    
    return "\(self.excursion.destinationName) \(self.excursion.name)"
  }
  
  func description() -> String {
    
    return self.excursion.description
  }
  
  func price() -> String {
    
    return String.init(format: "£%.2f", (Float)(self.excursion.price / 100.0))
  }
  
  func summary() -> String {
    
    return "\(self.excursion.destinationName) > \(self.excursion.name)\n\n\(self.excursion.description)\n\n\(self.price())"
  }
  
  func image() -> UIImage? {
    
    return UIImage.init(named: self.excursion.image) ?? UIImage.init()
  }
  
}
