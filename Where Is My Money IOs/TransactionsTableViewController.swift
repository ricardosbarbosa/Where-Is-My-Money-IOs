//
//  TransactionsTableViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 21/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class TransactionsTableViewController: UITableViewController {
  
  var ref : FIRDatabaseReference?
  var items: [Transaction] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    //self.performSegue(withIdentifier: "TransactionFormViewController",
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    self.tabBarController?.navigationItem.title = navigationItem.title
    self.tabBarController?.navigationItem.rightBarButtonItem = navigationItem.rightBarButtonItem
    
    if let user = FIRAuth.auth()?.currentUser {
      ref = FIRDatabase.database().reference(withPath: user.uid).child("transactions")
    }
    
    ref?.queryOrdered(byChild: "date").observe(.value, with: { snapshot in
      var newItems: [Transaction] = []
      
      for item in snapshot.children {
        let item = Transaction(snapshot: item as! FIRDataSnapshot)
        newItems.append(item)
      }
      
      self.items = newItems
      self.tableView.reloadData()
    })
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // TODO: next version will agrupater the transactions by day
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TransactionTableViewCell
    let item = items[indexPath.row]
    cell.item = item
    return cell
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
      // Delete the row from the data source
      tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
