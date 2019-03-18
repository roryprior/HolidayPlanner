//
//  DayTableViewCell.swift
//  Jet2Test
//
//  Created by Rory Prior on 13/03/2019.
//  Copyright © 2019 ThinkMac Software. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

  @IBOutlet var dayLabel : UILabel!
  @IBOutlet var monthLabel : UILabel!
  @IBOutlet var weatherIcon : UIImageView!
  @IBOutlet var weatherLabel : UILabel!
  @IBOutlet var highTempLabel : UILabel!
  @IBOutlet var lowTempLabel : UILabel!
  
  var dayViewModel : DayViewModel?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
  func updateUI() {
    
    guard dayViewModel != nil else {
      return
    }
    
    dayLabel.text = dayViewModel?.dayOfMonth()
    monthLabel.text = dayViewModel?.monthName()
    weatherIcon.image = dayViewModel?.weatherIcon()
    highTempLabel.text = dayViewModel?.highTemp()
    lowTempLabel.text = dayViewModel?.lowTemp()
    weatherLabel.text = dayViewModel?.weatherDescription()
    
  }
  
    
}
