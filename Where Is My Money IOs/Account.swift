//
//  Account.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase

public func ==(lhs: Account, rhs: Account) -> Bool {
  return lhs.name == rhs.name
}

public struct Account : Equatable, CustomStringConvertible {
  enum AccountType : String{
    case money, bank, creditcard
  }
  
  //firebase
  let key: String
  let ref: FIRDatabaseReference?
  //fields
  let name : String
  let type : AccountType
  var amount : Double
  
  init(name: String, type: AccountType, amount: Double, key: String = "") {
    self.key = key
    self.ref = nil
    
    self.name = name
    self.type = type
    self.amount = amount
  }
  
  init(snapshot: FIRDataSnapshot) {
    //firebase
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    ref = snapshot.ref
    //fields
    name = snapshotValue["name"] as! String
    type = Account.AccountType(rawValue: snapshotValue["type"] as! String)!
    amount = snapshotValue["amount"] as! Double
  }
  
  var any: Any {
    return [
      "name": name,
      "type": type.rawValue,
      "amount": amount
    ]
  }
  
  public var description: String {
    return name
  }
		
}
