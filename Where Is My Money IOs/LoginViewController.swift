//
//  LoginViewController.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 01/04/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {
  
  // MARK: Constants
  let loginToList = "LoginToList"
  
  // MARK: Outlets
  @IBOutlet weak var textFieldLoginEmail: UITextField!
  @IBOutlet weak var textFieldLoginPassword: UITextField!
  @IBOutlet weak var indicator: UIActivityIndicatorView!
  @IBOutlet weak var loginButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
      if user != nil {
        self.performSegue(withIdentifier: self.loginToList, sender: nil)
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    unsubscribeFromKeyboardNotifications()
  }
  
  func keyboardWillShow(_ notification:Notification) {
    view.frame.origin.y = 0 - getKeyboardHeight(notification)
  }
  func keyboardWillHide(_ notification:Notification) {
    view.frame.origin.y = 0
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
    return keyboardSize.cgRectValue.height
  }
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  
  // MARK: Actions
  @IBAction func loginDidTouch(_ sender: AnyObject) {
    
    guard let email = textFieldLoginEmail.text, !email.isEmpty,
      let password = textFieldLoginPassword.text, !password.isEmpty
      else {
        let alertController = UIAlertController(title: "Required fields.", message: "Fill the email and password", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil )
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        return
    }
    
    indicator.startAnimating()
    self.loginButton.isEnabled = false
    
    ApiSingleton.sharedInstance.verifyEmail(email: email) { (data, error) in
      
      DispatchQueue.main.async {
        self.indicator.stopAnimating()
        self.loginButton.isEnabled = true
      }
      
      if let error = error {
        let alertController = UIAlertController(title: "Error.", message: error.localizedDescription, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil )
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
      }
      else {
        let dict = (data as! Dictionary<String,Any>)
        let format_valid = dict["format_valid"] as? Bool ?? false
        
        if format_valid {
          DispatchQueue.main.async {
            FIRAuth.auth()!.signIn(withEmail: email, password: password)
          }
        }
        else {
          DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Informed email is not valid.", message: "Fill with a valid one", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil )
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
          }
        }
      }
    }
  }
  
  @IBAction func signUpDidTouch(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Register",
                                  message: "Register",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) { action in
                                    let emailField = alert.textFields![0]
                                    let passwordField = alert.textFields![1]
                                    
                                    FIRAuth.auth()!.createUser(withEmail: emailField.text!,
                                                               password: passwordField.text!) { user, error in
                                                                if error == nil {
                                                                  FIRAuth.auth()!.signIn(withEmail: self.textFieldLoginEmail.text!,
                                                                                         password: self.textFieldLoginPassword.text!)
                                                                }
                                    }
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)
    
    alert.addTextField { textEmail in
      textEmail.placeholder = "Enter your email"
    }
    
    alert.addTextField { textPassword in
      textPassword.isSecureTextEntry = true
      textPassword.placeholder = "Enter your password"
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textFieldLoginEmail {
      textFieldLoginPassword.becomeFirstResponder()
    }
    if textField == textFieldLoginPassword {
      textField.resignFirstResponder()
    }
    return true
  }
  
}
