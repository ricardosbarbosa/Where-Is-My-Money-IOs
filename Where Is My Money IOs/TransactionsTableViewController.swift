//
//  TransactionsTableViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 21/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase
import KCFloatingActionButton

class TransactionsTableViewController: UITableViewController {
  
  var fab = KCFloatingActionButton()
  let conditionRef = FIRDatabase.database().reference().child("condition")
  let ref = FIRDatabase.database().reference(withPath: "transactions")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutFAB()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  func layoutFAB() {
    let item = KCFloatingActionButtonItem()
    item.icon = UIImage(named: "income")
    item.buttonColor = UIColor.green
    item.title = "Income"
    item.handler = { item in
      let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      self.fab.close()
    }
    
    let item1 = KCFloatingActionButtonItem()
    item1.icon = UIImage(named: "outcome")
    item1.buttonColor = UIColor.red
    item1.title = "Income"
    item1.handler = { item in
      let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      self.fab.close()
    }
    
    let item2 = KCFloatingActionButtonItem()
    item2.icon = UIImage(named: "transfer")
    item2.buttonColor = UIColor.clear
    item2.title = "Transfer"
    item2.handler = { item in
      let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
      self.present(alert, animated: true, completion: nil)
      self.fab.close()
    }
    
   
    fab.addItem(item: item)
    fab.addItem(item: item1)
    fab.addItem(item: item2)
    fab.sticky = true
    
    print(tableView!.frame)
    
    self.view.addSubview(fab)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    conditionRef.observe(FIRDataEventType.value, with: { firDataSnapshot in
      print(firDataSnapshot.value ?? "?")
    })
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
  
  /*
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
   
   // Configure the cell...
   
   return cell
   }
   */
  
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
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
