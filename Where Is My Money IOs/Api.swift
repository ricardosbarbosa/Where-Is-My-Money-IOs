//
//  Api.swift
//  Where Is My Money IOs
//
//  Created by Ricardo Barbosa on 01/04/17.
//  Copyright © 2017 Ricardo Barbosa. All rights reserved.
//

import Foundation
let kNotificationStocksUpdated = "stocksUpdated"

let key = "PLACE-YOUR-API-KEY-HERE" //https://mailboxlayer.com/dashboard

class ApiSingleton {
  
  class var sharedInstance : ApiSingleton {
    struct Static {
      static let instance : ApiSingleton = ApiSingleton()
    }
    return Static.instance
  }
  
  public func verifyEmail(email:String, completionHandler: @escaping (Any?, Error?) -> Void) {
    
    let urlComponents = NSURLComponents(string: "http://apilayer.net/api/check")!
    
    urlComponents.queryItems = [
      URLQueryItem(name: "access_key", value: key),
      URLQueryItem(name: "email", value: email)
    ]
    
    let request = NSMutableURLRequest(url: urlComponents.url!)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
      if error != nil { // Handle error...
        completionHandler(nil, error)
        return
      }
      
      if let data = data {
        print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
        
        // parse the data
        let parsedResult: [String:Any]?
        do {
          parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary
          
          completionHandler(parsedResult, error)
          
        } catch let e {
          print("Could not parse the data as JSON: '\(data)'")
          completionHandler(nil, e)
          return
        }
      }
    }
    
    task.resume()
  }
  
}
