//
//  AccountFormViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class AccountFormViewController: FormViewController {
  
  let ref = FIRDatabase.database().reference(withPath: "accounts")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    createForm()
  }
  
  func createForm() {
    URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
    LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
    CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
    DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }
    
    form +++
      
      Section()
      
      <<< TextRow() {
        $0.tag = "TextRow"
        $0.title = "Name"
        $0.placeholder = "Money"
        $0.add(rule: RuleRequired())
        $0.validationOptions = .validatesOnChange
      }
      
      
      <<< PushRow<Account.AccountType>() {
        $0.tag = "PushRow"
        $0.title = "Type"
        $0.options = [.bank,.money,.creditcard]
        $0.value = .money
        $0.selectorTitle = "Choose a Type"
        $0.add(rule: RuleRequired())
        $0.validationOptions = .validatesOnChange
      }
      
      <<< DecimalRow() {
        $0.tag = "DecimalRow"
        $0.title = "Initial ammout"
        $0.value = 0
        $0.formatter = DecimalFormatter()
        $0.useFormatterDuringInput = true
        //$0.useFormatterOnDidBeginEditing = true
        }.cellSetup { cell, _  in
          cell.textField.keyboardType = .numberPad
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func saveAction(_ sender: Any) {
    let errors = form.validate()
    if !errors.isEmpty {
      return
    }
    // Get the value of a single row
    let textRow : TextRow? = form.rowBy(tag: "TextRow")
    let pushRow : PushRow<Account.AccountType>? = form.rowBy(tag: "PushRow")
    let decimalRow: DecimalRow? = form.rowBy(tag: "DecimalRow")
    
    let name = textRow?.value ?? ""
    let ammount = decimalRow?.value ?? 0.0
    let type = pushRow?.value ?? .money
    
    let item = Account(name: name, type: type, amount: ammount)
    let groceryItemRef = self.ref.childByAutoId()
    groceryItemRef.setValue(item.any)
    
    _ = navigationController?.popViewController(animated: true)
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
