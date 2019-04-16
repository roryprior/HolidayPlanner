//
//  WeatherChecker.swift
//  HolidayPlanner
//
//  Created by Rory Prior on 14/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import Foundation

class WeatherChecker : APIRequest {
  
  private let appID = "3e2161379fa2f3e61026dd8d38b18041" // account key for accessing the weather API

  /*
   * Get 5 days of weather information. Because the OpenWeatherMap API sometimes only returns a 4 day forecast
   * from the next calendar day, we have to perform two API requests, one to get today's weather
   * and another to get the forecast. The JSON responses are also slightly different between these.
   * Note there is a limit of 60 API requests a minute.
   */
  func fetchWeather(city: String, completion:@escaping (_ days : Array<Day>?, _ error: Error?) -> Void) {
    
    let weatherEndPoint = URL(string: "https://api.openweathermap.org/data/2.5/weather")
    let weatherParams = [
      "q": city,
      "appid": appID,
      "units": "metric",
      ]
    
    // Request weather forecast for the next 4 days
    super.sendRequest(URL: weatherEndPoint, params: weatherParams, method: "GET") { (data, error) in
      
      guard data != nil else {
        completion(nil, error)
        return
      }
      
      let json = try? JSONSerialization.jsonObject(with: data!, options: [])
    
      var days = Array.init() as Array<Day>
      
      if let dictionary = json as? [String: Any],
         let dateValue = dictionary["dt"] as? Double,
         let main = dictionary["main"] as? [String : Any],
         let tempMin = (main["temp_min"] as? NSNumber)?.floatValue,
         let tempMax = (main["temp_max"] as? NSNumber)?.floatValue,
         let weather = dictionary["weather"] as? Array<[String : Any]>,
         let description = weather[0]["description"] as? String,
         let iconCode = weather[0]["icon"] as? String {
        
        var today = Day.init()
        today.date = Date.init(timeIntervalSince1970: dateValue)
        today.icon = iconCode
        today.description = description
        today.lowTemp = tempMin
        today.highTemp = tempMax
        
        days.append(today)
      }
        
      self.fetchForecast(city: city, existingDays: days, completion: completion)
    }
  }
    
  func fetchForecast(city: String, existingDays: Array<Day>, completion:@escaping (_ days : Array<Day>?, _ error: Error?) -> Void) {
    
    let forecastEndPoint = URL(string: "https://api.openweathermap.org/data/2.5/forecast")
    let forecastParams = [
      "q": city,
      "appid": appID,
      "units": "metric",
      ]
    
    var days = Array.init() as Array<Day>
    days.append(contentsOf: existingDays)
    
    // Request weather forecast for the next 4~5 days
    super.sendRequest(URL: forecastEndPoint, params: forecastParams, method: "GET") { (data, error) in
      
      guard data != nil else {
        completion(nil, error)
        return
      }
      
      let json = try? JSONSerialization.jsonObject(with: data!, options: [])
      
      let calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
      
      if let dictionary = json as? [String: Any], let list = dictionary["list"] as? Array<[String : Any]> {
        
        var currentDay = Day.init()
        
        for listItem in list {
          
          if let dateValue = listItem["dt"] as? Double,
            let main = listItem["main"] as? [String : Any],
            let temp = (main["temp"] as? NSNumber)?.floatValue,
            let weather = listItem["weather"] as? Array<[String : Any]>,
            let description = weather[0]["description"] as? String,
            let iconCode = weather[0]["icon"] as? String {
            
            let date = Date.init(timeIntervalSince1970: dateValue)
            
            // If we don't currently have a date for our day stuct, set it now.
            if currentDay.date == nil {
               currentDay.date = date
               currentDay.icon = iconCode
               currentDay.description = description
            }
              // if we do have a date, prefer to use the weather forecast from 12 or 1pm (if possible) as the API won't give us a daily summary
            else if calendar.dateComponents([.day], from: currentDay.date!).day ==
                    calendar.dateComponents([.day], from: date).day {
              
              
              if(calendar.dateComponents([.hour], from: date).hour == 12 ||
                 calendar.dateComponents([.hour], from: date).hour == 13) {
                currentDay.icon = iconCode
                currentDay.description = description
              }
            }
            // It's a new day, store the current day and initalise a new day stuct
            else {
              
              // avoid duplicating the weather forecast for today if we already have it
              if calendar.dateComponents([.day], from: currentDay.date!).day !=
                 calendar.dateComponents([.day], from: days[0].date!).day {
                days.append(currentDay)
              }
              
              currentDay = Day.init()
              currentDay.date = date
              currentDay.icon = iconCode
              currentDay.description = description
            }
            
            if(temp > currentDay.highTemp) { currentDay.highTemp = temp }
            if(temp < currentDay.lowTemp) { currentDay.lowTemp = temp }
          }
        }
        
        completion(days, error)
      }
    }
  }
  
  /**
   * Not currently used as we're including the icons in the app bundle, but should
   * we want to get the icons from the web service this is the URL scheme to use.
   */
  func weatherIconURLFor(code: String) -> URL? {
    
    return URL.init(string: "https://openweathermap.org/img/w/\(code).png")
    
  }
}
