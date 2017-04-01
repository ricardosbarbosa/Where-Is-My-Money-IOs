//
//  AccountTableViewCell.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
  
  var item: Account? {
    didSet{
      updateUI()
    }
  }
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
 
  func updateUI() {
    titleLabel.text = item?.name
    subtitleLabel.text = item?.type.rawValue
    amountLabel.text = String(format: "%.2f", item?.amount ?? 0)
    amountLabel.textColor = item?.amount ?? 0 >= 0 ? UIColor.green : UIColor.red
  }
}
