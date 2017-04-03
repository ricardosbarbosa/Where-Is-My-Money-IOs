//
//  User.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 01/04/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import Foundation
import Firebase

struct User {
  
  let uid: String
  let email: String
  
  init(authData: FIRUser) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
  
}
