//
//  AccountsTableViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class AccountsTableViewController: UITableViewController {
  
  var ref : FIRDatabaseReference?
  var items: [Account] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.tabBarController?.navigationItem.title = navigationItem.title
    self.tabBarController?.navigationItem.rightBarButtonItem = navigationItem.rightBarButtonItem
    
    if let user = FIRAuth.auth()?.currentUser {
      ref = FIRDatabase.database().reference(withPath: user.uid).child("accounts")
    }
    
    ref?.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
      print(snapshot.value)
      var newItems: [Account] = []
      
      for item in snapshot.children {
        let categoryItem = Account(snapshot: item as! FIRDataSnapshot)
        newItems.append(categoryItem)
      }
      
      self.items = newItems
      self.tableView.reloadData()
    })
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
    let item = items[indexPath.row]
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = String(format: "%.2f", item.amount )
    
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    switch items[indexPath.row].amount  {
    case let x where x < 0.0:
      cell.backgroundColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    case let x where x > 0.0:
      cell.backgroundColor = UIColor(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    case _:
      cell.backgroundColor = UIColor(red: 44.0/255.0, green: 186.0/255.0, blue: 231.0/255.0, alpha: 1.0)
    }
    
    cell.textLabel!.textColor = UIColor.white
    cell.detailTextLabel!.textColor = UIColor.white
    cell.textLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 30)
    cell.detailTextLabel!.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 30)
    cell.textLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    cell.textLabel!.shadowOffset = CGSize(width: 0, height: 1)
    cell.detailTextLabel!.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    cell.detailTextLabel!.shadowOffset = CGSize(width: 0, height: 1)
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = items[indexPath.row]
      item.ref?.removeValue()
    }
  }
  
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
