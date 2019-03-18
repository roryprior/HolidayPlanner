//
//  ExcursionTableViewController.swift
//  Jet2Test
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class ExcursionTableViewController: UITableViewController {

  private let excursionReuseIdentifier = "ExcursionCell"
  private let dayReuseIdentifier = "DayCell"
  
  var excursionManager = ExcursionManager.init()
  var destination : Destination?
  var day : Day?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.allowsSelection = false
    self.tableView.register(UINib.init(nibName: "ExcursionTableViewCell", bundle: nil), forCellReuseIdentifier: excursionReuseIdentifier)
    self.tableView.register(UINib.init(nibName: "DayTableViewCell", bundle: nil), forCellReuseIdentifier: dayReuseIdentifier)
  }
  
  func updateFor(destination aDestination: Destination, dayIndex: Int) {
    
    let excursionChecker = ExcursionChecker.init()
    
    self.destination = aDestination
    self.day = aDestination.days[dayIndex]
    if let date = day?.date {
  
      excursionChecker.fetchExcursions(destination: aDestination.name, date: date, completion: { (excursions, error) in
        guard error == nil else {
          print("Error \(error!.localizedDescription)")
          return
        }
        
        guard excursions != nil else {
          print("No data")
          return
        }
        
        self.day?.excursions = excursions
        
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      })
    }
  }
  
  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
    }
    else {
      return day?.excursions?.count ?? 0
    }
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: dayReuseIdentifier, for: indexPath) as! DayTableViewCell
      
      if self.day != nil {
        let dayViewModel = DayViewModel.init(with: self.day!)
        cell.dayViewModel = dayViewModel
        cell.updateUI()
        cell.accessoryType = .none
      }
      
      return cell
    }
    else {
      let cell = tableView.dequeueReusableCell(withIdentifier: excursionReuseIdentifier, for: indexPath) as! ExcursionTableViewCell
      
      if let excursion = self.day?.excursions?[indexPath.row] {
        let excursionViewModel = ExcursionViewModel.init(with: excursion)
        cell.excursionViewModel = excursionViewModel
        cell.updateUI()
        
        cell.shareAction = { () in
          let items = [excursionViewModel.summary(), excursionViewModel.image()!] as [Any]
          let viewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
          self.present(viewController, animated: true)
        }
        
        cell.saveAction = { () in
          
          self.excursionManager.add(excursion: excursion)
          
          let alert = UIAlertController.init(title: "Saved", message: "This excursion has been saved. You can view your saved excursions from the Destinations screen", preferredStyle: .alert)
          alert.addAction(UIAlertAction.init(title: "Done", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
        
        cell.accessoryType = .none
      }
      
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    // weather info cell
    if indexPath.section == 0 {
      return 70
    }
    // excursion detail cells
    else {
      return 320
    }
  }
}
