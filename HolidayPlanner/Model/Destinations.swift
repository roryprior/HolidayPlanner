//
//  Destinations.swift
//  HolidayPlanner
//
//  Simply provides a list of popular holiday destinations. In a real world app
//  this would probably be returned by an API call.
//
//  Created by Rory Prior on 15/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class Destinations {

  let destinations = [["name" : "Alicante", "code" : "ES"],
            ["name" : "Almeria", "code" : "ES"],
            ["name" : "Amsterdam", "code" : "NL"],
            ["name" : "Antalya", "code" : "TR"],
            ["name" : "Barcelona", "code" : "ES"],
            ["name" : "Belfast", "code" : "UK"],
            ["name" : "Bergerac", "code" : "FR"],
            ["name" : "Berlin", "code" : "DE"],
            ["name" : "Birmingham", "code" : "UK"],
            ["name" : "Bodrum", "code" : "TR"],
            ["name" : "Bourgas", "code" : "BG"],
            ["name" : "Budapest", "code" : "HU"],
            ["name" : "Cologne", "code" : "DE"],
            ["name" : "Copenhagen", "code" : "DK"],
            ["name" : "Corfu", "code" : ""],
            ["name" : "Crete", "code" : "GR"],
            ["name" : "Dalaman", "code" : "TR"],
            ["name" : "Dubrovnik", "code" : "HR"],
            ["name" : "Derby", "code" : "UK"],
            ["name" : "Edinburgh", "code" : "UK"],
            ["name" : "Faro", "code" : "PT"],
            ["name" : "Geneva", "code" : "CH"],
            ["name" : "Girona", "code" : "ES"],
            ["name" : "Glasgow", "code" : "UK"],
            ["name" : "Grenoble", "code" : "FR"],
            ["name" : "Ibiza", "code" : "ES"],
            ["name" : "Izmir", "code" : "TR"],
            ["name" : "Jersey", "code" :""],
            ["name" : "Kefalonia", "code" : ""],
            ["name" : "Kos", "code" : "GR"],
            ["name" : "Krakow", "code" : "PL"],
            ["name" : "La Rochelle", "code" : ""],
            ["name" : "Larnaca", "code" : ""],
            ["name" : "Leeds", "code" : "UK"],
            ["name" : "Lleida", "code" : ""],
            ["name" : "London", "code" : "UK"],
            ["name" : "Lyon", "code" : "FR"],
            ["name" : "Madeira", "code" : ""],
            ["name" : "Majorca", "code" : ""],
            ["name" : "Malaga", "code" : ""],
            ["name" : "Malta", "code" : ""],
            ["name" : "Manchester", "code" : "UK"],
            ["name" : "Menorca", "code" : ""],
            ["name" : "Murcia", "code" : "ES"],
            ["name" : "Naples", "code" : "IT"],
            ["name" : "Newcastle", "code" : "UK"],
            ["name" : "New York", "code" : "US"],
            ["name" : "Nice", "code" : "FR"],
            ["name" : "Nuremberg", "code" : "DE"],
            ["name" : "Paphos", "code" : "GR"],
            ["name" : "Paris", "code" : "FR"],
            ["name" : "Pisa", "code" : "IT"],
            ["name" : "Prague", "code" : "CZ"],
            ["name" : "Pula", "code" : "HR"],
            ["name" : "Reus", "code" : "ES"],
            ["name" : "Reykjavik", "code" : "IS"],
            ["name" : "Rhodes", "code" : "GR"],
            ["name" : "Rome", "code" : "IT"],
            ["name" : "Salzburg", "code" : "AT"],
            ["name" : "Split", "code" : "HR"],
            ["name" : "Tenerife", "code" : ""],
            ["name" : "Thessaloniki", "code" : ""],
            ["name" : "Turin", "code" : "IT"],
            ["name" : "Venice", "code" : "IT"],
            ["name" : "Verona", "code" : "IT"],
            ["name" : "Vienna", "code" : "AT"],
            ["name" : "Zante", "code" : ""]] as Array<[String : String]>
  
  func totalDestinations() -> Int {
    return destinations.count
  }
  
  func destination(index: Int) -> Destination {
    return Destination.init(name: destinations[index]["name"] ?? "???", code: destinations[index]["code"] ?? "", days: Array())
  }
}
