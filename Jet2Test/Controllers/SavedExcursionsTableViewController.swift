//
//  SavedExcursionsTableViewController.swift
//  Jet2Test
//
//  Created by Rory Prior on 18/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class SavedExcursionsTableViewController: UITableViewController {

  private let excursionReuseIdentifier = "ExcursionCell"
  var excursionManager = ExcursionManager.init()
  
  override func viewDidLoad() {
  
    super.viewDidLoad()
    self.title = "Saved Excursions"
    self.tableView.allowsSelection = false
    self.tableView.rowHeight = 320
    self.tableView.register(UINib.init(nibName: "ExcursionTableViewCell", bundle: nil), forCellReuseIdentifier: excursionReuseIdentifier)
    self.tableView.reloadData()
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

    return self.excursionManager.excursions.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: excursionReuseIdentifier, for: indexPath) as! ExcursionTableViewCell
    
    let excursion = self.excursionManager.excursions[indexPath.row]
    let excursionViewModel = ExcursionViewModel.init(with: excursion)
    cell.excursionViewModel = excursionViewModel
    cell.updateUI()
    cell.saveButton.isHidden = true
    
    cell.shareAction = { () in
      let items = [excursionViewModel.summary(), excursionViewModel.image()!] as [Any]
      let viewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
      self.present(viewController, animated: true)
    }
    return cell
  }
  
  @IBAction func clearSavedExcursions(sender: Any) {
    self.excursionManager.clear()
    self.tableView.reloadData()
  }
}
