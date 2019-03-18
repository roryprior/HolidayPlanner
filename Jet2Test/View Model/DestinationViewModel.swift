//
//  DestinationViewModel.swift
//  Jet2Test
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class DestinationViewModel {
  
  var destination : Destination?
  
  init(with aDestination: Destination) {
    destination = aDestination
  }
  
  func name() -> String {
    return destination?.name ?? "???"
  }
  
  
}
