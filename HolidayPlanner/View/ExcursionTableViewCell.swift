//
//  ExcursionTableViewCell.swift
//  HolidayPlanner
//
//  Created by Rory Prior on 16/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class ExcursionTableViewCell: UITableViewCell {

  @IBOutlet var nameLabel : UILabel!
  @IBOutlet var descriptionLabel : UILabel!
  @IBOutlet var priceLabel : UILabel!
  @IBOutlet var photoImageView : UIImageView!
  @IBOutlet var saveButton : UIButton!
  
  var saveAction: (() -> Void)?
  var shareAction: (() -> Void)?
  
  var excursionViewModel : ExcursionViewModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  func updateUI() {
    
    guard excursionViewModel != nil else {
      return
    }
    
    nameLabel.text = excursionViewModel?.name()
    descriptionLabel.text = excursionViewModel?.description()
    priceLabel.text = excursionViewModel?.price()
    photoImageView.image = excursionViewModel?.image()
  }
  
  @IBAction func doSave(sender: Any) {
    if saveAction != nil {
      saveAction!()
    }
  }
  
  @IBAction func doShare(sender: Any) {
    if shareAction != nil {
      shareAction!()
    }
  }

}
