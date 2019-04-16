//
//  DestinationDetailTableViewController.swift
//  HolidayPlanner
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class DestinationDetailTableViewController: UITableViewController {

  private let reuseIdentifier = "WeatherCell"
  var destinationViewModel : DestinationViewModel?
  var destination : Destination?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.rowHeight = 70
    self.tableView.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setToolbarHidden(true, animated: false)
  }

  func updateFor(destination aDestination: Destination) {
   
    let weatherChecker = WeatherChecker.init()
    
    self.destination = aDestination
    
    var cityString = "\(aDestination.name),\(aDestination.code)"
    if aDestination.code == "" {
      cityString = aDestination.name
    }
    
    weatherChecker.fetchWeather(city: cityString) { (days, error) in
      guard error == nil else {

        DispatchQueue.main.async { [weak self] in
          let alert = UIAlertController.init(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
          alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
          self?.present(alert, animated: true, completion: nil)
        }
        return
      }
      
      guard days != nil else {
        
        DispatchQueue.main.async { [weak self] in
          let alert = UIAlertController.init(title: "Error", message: "Sorry I can't find any weather data for this destination!", preferredStyle: .alert)
          alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: nil))
          self?.present(alert, animated: true, completion: nil)
        }
        return
      }
        
      self.destination!.days = days!
      
      DispatchQueue.main.async { [weak self] in
        guard self?.destination != nil else { return }
        self?.destinationViewModel = DestinationViewModel.init(with: self!.destination!)
        self?.title = self?.destinationViewModel?.name()
        self?.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Table view data source
  /* for single responsibility reasons we could split the datasource out into a seperate file
     however it's overkill for this simple app. */

  override func numberOfSections(in tableView: UITableView) -> Int {
    
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return self.destination?.days.count ?? 0
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! DayTableViewCell

    if let days = self.destination?.days {
      let dayViewModel = DayViewModel.init(with: days[indexPath.row])
      cell.dayViewModel = dayViewModel
      cell.updateUI()
    }

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Excursions") as! ExcursionTableViewController
    viewController.updateFor(destination: self.destination!, dayIndex: indexPath.row)
    self.navigationController?.pushViewController(viewController, animated: true)
    
  }
}
