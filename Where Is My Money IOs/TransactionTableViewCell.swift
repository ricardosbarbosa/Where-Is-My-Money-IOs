//
//  TransactionTableViewCell.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
  
  var item: Transaction? {
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
    if selected {
      backgroundColor = UIColor.black
    }
  }
  
  func updateUI() {
    titleLabel.text = item?.detail
    subtitleLabel.text = item?.type.rawValue
    amountLabel.text = String(format: "%.2f", item?.value ?? 0)
    imageView?.image = item?.type == .income ?
      UIImage(named: "income-ball") :
      item?.type == .expense ? UIImage(named: "expense-ball") : UIImage(named: "transfer-ball")
  }
}
