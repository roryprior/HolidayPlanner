//
//  DestinationsTableViewController.swift
//  HolidayPlanner
//
//  Created by Rory Prior on 15/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class DestinationsTableViewController: UITableViewController {

  private let cellIdentifier = "destinationCell"
  let destinations = Destinations.init()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Destinations" // TODO: localise
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.setToolbarHidden(false, animated: true)
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {

    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return destinations.totalDestinations()
  }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

    // Configure the cell...
    
    let destination = DestinationViewModel.init(with: destinations.destination(index: indexPath.row))
    
    cell.textLabel?.text = destination.name()
    cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail") as! DestinationDetailTableViewController
    viewController.updateFor(destination: destinations.destination(index: indexPath.row))
    self.navigationController?.pushViewController(viewController, animated: true)
    
  }
}
