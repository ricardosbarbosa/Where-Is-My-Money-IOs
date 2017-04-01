//
//  TransactionFormViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class TransactionFormViewController: FormViewController {
  
  let ref = FIRDatabase.database().reference(withPath: "transactions")
  let refTransfers = FIRDatabase.database().reference(withPath: "transfers")
  
  let refCategories = FIRDatabase.database().reference(withPath: "categories")
  var categories: [Category] = []
  
  let refAccounts = FIRDatabase.database().reference(withPath: "accounts")
  var accounts: [Account] = []

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    refCategories.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
      var newItems: [Category] = []
      
      for item in snapshot.children {
        let categoryItem = Category(snapshot: item as! FIRDataSnapshot)
        newItems.append(categoryItem)
      }
      
      self.categories = newItems
      self.createForm()
    })
    
    refAccounts.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
      var newItems: [Account] = []
      
      for item in snapshot.children {
        let accountItem = Account(snapshot: item as! FIRDataSnapshot)
        newItems.append(accountItem)
      }
      
      self.accounts = newItems
      self.createForm()
    })
  
    
    
  }
  
  
  func createForm() {
    
    form.removeAll()
    
    URLRow.defaultCellUpdate = { cell, row in cell.textField.textColor = .blue }
    LabelRow.defaultCellUpdate = { cell, row in cell.detailTextLabel?.textColor = .orange  }
    CheckRow.defaultCellSetup = { cell, row in cell.tintColor = .orange }
    DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }
    
    form +++
      Section()
      <<< SegmentedRow<Transaction.TransactionType>("Type"){
        $0.tag = "TypeRow"
        $0.options = [.income,.expense,.transfer]
        $0.value = .income
    }
    
      +++ Section()
      
      <<< DateRow() {
        $0.tag = "DateRow"
        $0.value = Date()
        $0.title = "Date"
      }
      
      <<< TextRow() {
        $0.tag = "TextRow"
        $0.title = "Detail"
        $0.placeholder = "Movies"
      }
      
      <<< DecimalRow() {
        $0.tag = "DecimalRow"
        $0.title = "Value"
        $0.value = 0
        $0.formatter = DecimalFormatter()
        $0.useFormatterDuringInput = true
        //$0.useFormatterOnDidBeginEditing = true
        }.cellSetup { cell, _  in
          cell.textField.keyboardType = .numberPad
      }
      
      <<< PushRow<Account>() {
        $0.tag = "AccountPushRow"
        $0.title = "Account"
        $0.options = accounts
        $0.value = nil
        $0.selectorTitle = "Choose a Account"
      }

      <<< PushRow<Account>() {
        $0.tag = "AccountDestinyPushRow"
        $0.title = "Destiny Account"
        $0.options = accounts
        $0.value = nil
        $0.selectorTitle = "Choose a Account"
        $0.hidden =  Condition.function(["TypeRow"], { form in
          return !((form.rowBy(tag: "TypeRow") as? SegmentedRow<Transaction.TransactionType>)?.value == .transfer)
        })
      }

      <<< PushRow<Category>() {
        $0.tag = "CategoryPushRow"
        $0.title = "Category"
        $0.options = categories
        $0.value = nil
        $0.selectorTitle = "Choose a Category"
    }
    
  }
  @IBAction func saveAction(_ sender: Any) {
    // Get the value of a single row
    let typeRow : SegmentedRow<Transaction.TransactionType>? = form.rowBy(tag: "TypeRow")
    let dateRow : DateRow? = form.rowBy(tag: "DateRow")
    let textRow : TextRow? = form.rowBy(tag: "TextRow")
    let decimalRow: DecimalRow? = form.rowBy(tag: "DecimalRow")
    let pushAccountRow : PushRow<Account>? = form.rowBy(tag: "AccountPushRow")
    let pushCategoryRow : PushRow<Category>? = form.rowBy(tag: "CategoryPushRow")
    
    let date = dateRow!.value!
    let detail = textRow!.value!
    let value = decimalRow!.value!
    let type = typeRow!.value!
    let account = pushAccountRow!.value!
    let category = pushCategoryRow!.value!
    
    let transaction = Transaction(date: date, detail: detail, value: value, type: type, account: account, category: category)
    
    let transactionRef = self.ref.childByAutoId()
    transactionRef.setValue(transaction.any)
    
    if type == .transfer {
      let pushDestinyAccountRow : PushRow<Account>? = form.rowBy(tag: "AccountDestinyPushRow")
      let accountDestiny = pushDestinyAccountRow!.value!
      let transfer = TransferTransaction(transaction: transaction, destiny_account: accountDestiny)
      
      let transferRef = self.refTransfers.childByAutoId()
      var values = transfer.any as? [String: Any]
      values?["transaction_key"] = transactionRef.key
      transferRef.setValue(values)
    }
    
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
