//
//  CategoryTransaction.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase


public func ==(lhs: Category, rhs: Category) -> Bool {
  return lhs.name == rhs.name
}


public struct Category : Equatable, CustomStringConvertible  {
  //firebase
  let key: String
  let ref: FIRDatabaseReference?
  //fields
  let name: String
  
  init(name: String, key: String = "") {
    self.key = key
    self.name = name
    self.ref = nil
  }
  
  init(snapshot: FIRDataSnapshot) {
    //firebase
    key = snapshot.key
    let snapshotValue = snapshot.value as! [String: AnyObject]
    ref = snapshot.ref
    //fields
    name = snapshotValue["name"] as! String
  }
  
  var any: Any {
    return [
      "name": name
    ]
  }
  
  public var description: String {
    return name
  }
}
