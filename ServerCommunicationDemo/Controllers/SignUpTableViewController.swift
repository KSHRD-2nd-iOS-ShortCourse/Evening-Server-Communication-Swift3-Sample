//
//  SignUpTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/16/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class SignUpTableViewController: UITableViewController, NVActivityIndicatorViewable {
    
    // Outlet
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: [UITextField]!
    @IBOutlet var genderSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TODO: SignIn IBAction
    @IBAction func signUpAction(_ sender: Any) {
        // Create NVActivityIndicator
        let size = CGSize(width: 30, height:30)
        self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballZigZag)
        
        
        // Validation
        if passwordTextField[0].text != passwordTextField[1].text {
            print("password not match")
            self.stopAnimating()
            return
        }
        
        // Create dictionary for request paramater
        let paramater = [
            "Name" : nameTextField.text!,
            "Gender" : genderSegmentedControl.selectedSegmentIndex == 0 ? "m" : "f",
            "UserName": emailTextField.text!,
            "Password": passwordTextField[0].text!
            ] as [String : Any]
        
        print(paramater)
        
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
                self.stopAnimating()
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    
                    // show other NVActivityIndicator
                    self.startAnimating(size, message: "Success...", type: NVActivityIndicatorType.ballRotate)
                    self.perform(#selector(self.delayedStopActivity), with: nil, afterDelay: 2.5)
                }
        }
    }
    
    // TODO: Stop NVActivityIndicator
    func delayedStopActivity() {
        stopAnimating()
    }
}
