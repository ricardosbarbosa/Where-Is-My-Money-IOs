//
//  FireViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 21/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase

class FireViewController: UIViewController {
  
  let conditionRef = FIRDatabase.database().reference().child("condition")
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBOutlet weak var label: UILabel!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    conditionRef.observe(FIRDataEventType.value, with: { firDataSnapshot in
      print(firDataSnapshot.value ?? "?")
      self.label.text = firDataSnapshot.value as? String
    })
  }
  
  @IBAction func foggyAction(_ sender: Any) {
    conditionRef.setValue("foggy")
  }
  @IBAction func sunnyAction(_ sender: Any) {
    conditionRef.setValue("sunny")
  }
  
}
