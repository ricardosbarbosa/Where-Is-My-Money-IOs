//
//  WISMMTabBarViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 01/04/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import FirebaseAuth
import RAMAnimatedTabBarController

class WISMMTabBarViewController: RAMAnimatedTabBarController {
  
  @IBOutlet var signOutButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let viewControllers = viewControllers {
      for vc in viewControllers {
        vc.tabBarController?.navigationItem.leftBarButtonItem = signOutButton
      }
    }
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  @IBAction func signoutButtonPressed(_ sender: AnyObject) {
    do {
      try FIRAuth.auth()!.signOut()
      dismiss(animated: true, completion: nil)
    } catch {
      
    }
  }
}
