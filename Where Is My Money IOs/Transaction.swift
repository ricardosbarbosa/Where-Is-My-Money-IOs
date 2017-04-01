//
//  Transaction.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase

public struct Transaction {
  enum TransactionType : String, CustomStringConvertible {
    case income, expense, transfer
    
    var description: String {
      return rawValue
    }
    
  }
  //firebase
  let key: String
  let ref: FIRDatabaseReference?
  //fields
  let date : Date
  let detail: String
  var value : Double
  let type : TransactionType
  let account: Account
  let category: Category
  
  init(date: Date, detail: String, value: Double, type: TransactionType, account: Account, category: Category, key: String = "") {
    self.key = key
    self.ref = nil
    
    self.date = date
    self.detail = detail
    self.value = value
    self.type = type
    self.account = account
    self.category = category
  }
  
  init(snapshot: FIRDataSnapshot) {
    //firebase
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    ref = snapshot.ref
    //fields
    date = Date(timeIntervalSince1970: snapshotValue["date"] as! Double)
    detail = snapshotValue["detail"] as! String
    value = snapshotValue["value"] as! Double
    
    type = Transaction.TransactionType(rawValue: snapshotValue["type"] as! String)!
    category = Category(snapshot: snapshot.childSnapshot(forPath: "category"))
    account = Account(snapshot: snapshot.childSnapshot(forPath: "account"))
  }
  
  var any: Any {
    return [
      "type": type.rawValue,
      "date": date.timeIntervalSince1970,
      "detail": detail,
      "value": value,
      "account": account.any,
      "category": category.any,
      "accountKey": account.key,
      "categoryKey": account.key
    ]
  }

}

public struct TransferTransaction {
  let transaction : Transaction
  let destiny_account : Account
  
  var any : Any {
    return [
      "transaction": transaction.any,
      "transaction_key": transaction.key,
      "destiny_account": destiny_account.any,
      "destiny_account_key": destiny_account.key,
    ]
  }
}
