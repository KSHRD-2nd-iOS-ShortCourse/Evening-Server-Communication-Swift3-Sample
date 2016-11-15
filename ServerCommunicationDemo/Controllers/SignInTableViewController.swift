//
//  SignInTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/10/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class SignInTableViewController: UITableViewController {
    
    // Outlet
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: SignIn IBAction
    @IBAction func signInAction(_ sender: Any) {
        signIn(username: emailTextField.text!, password: passwordTextField.text!)
    }
}



// TODO: Extension SignInTableViewController
extension SignInTableViewController {
    
    // MARK: signIn method
    func signIn(username: String, password: String) {
        // Create dictionary as request paramater
        let paramater = [
            "UserName": "\(username)",
            "Password": "\(password)"
            ] as [String : Any]
        
        /*
         Request :
         - JSONEncoding type creates a JSON representation of the parameters object
         */
        Alamofire.request("http://fakerestapi.azurewebsites.net/api/Users",
                          method: .post,
                          parameters: paramater,
                          encoding: JSONEncoding.default)
            
            // Response from server
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    
                    // Create storyboard by name
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    
                    // Create view controller object by InitialViewController
                    // let vc = storyboard.instantiateInitialViewController()
                    
                    // Create view controller object by ViewController Identifier
                    let vc = storyboard.instantiateInitialViewController()
                    
                    // open view controller
                    self.present(vc!, animated: true, completion: nil)
                }
        }
    }
    
    
    // MARK: Get user
    func getUser() {
        
        /*
         Request
         */
        Alamofire.request("http://fakerestapi.azurewebsites.net/api/Users").responseJSON { response in
            print(response.request ?? "your value is nil")  // original URL request
            print(response.response ?? "abc") // HTTP URL response
            print(response.data  ?? "")     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                // let jsonArray = JSON as! [AnyObject]
                // let jsonDictionary = jsonArray[0] as! [String : AnyObject]
                print("JSON: \(JSON)")
            }
        }
    }
}
