//
//  CategoriesTableViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 22/03/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import Firebase
import KCFloatingActionButton

class CategoriesTableViewController: UITableViewController {
  
  let ref = FIRDatabase.database().reference(withPath: "categories")
  var items: [Category] = []
  
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
    
    ref.queryOrdered(byChild: "name").observe(.value, with: { snapshot in
      print(snapshot.value)
      var newItems: [Category] = []
      
      for item in snapshot.children {
        let categoryItem = Category(snapshot: item as! FIRDataSnapshot)
        newItems.append(categoryItem)
      }
      
      self.items = newItems
      self.tableView.reloadData()
    })
  }
  
  @IBAction func addCategory(_ sender: Any) {
    let alert = UIAlertController(title: "Category Item",
                                  message: "Add an Item",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) { _ in
                                    guard let textField = alert.textFields?.first,
                                      let text = textField.text else { return }
                                    let groceryItem = Category(name: text)
                                    let groceryItemRef = self.ref.child(text.lowercased())
                                    groceryItemRef.setValue(groceryItem.any)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)     
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)

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

