//
//  ForgetPasswordTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/16/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class ForgetPasswordTableViewController: UITableViewController, NVActivityIndicatorViewable {

    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func resetPasswordAction(_ sender: Any) {
        let size = CGSize(width: 30, height:30)
        self.startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballZigZag)
        
        // Create dictionary as request paramater
        let paramater = [
            "UserName": "\(emailTextField.text!)",
            "Password": "123"
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
                self.stopAnimating()
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                    
                    self.startAnimating(size, message: "Success...", type: NVActivityIndicatorType.ballRotate)
                    self.perform(#selector(self.delayedStopActivity),
                            with: nil,
                            afterDelay: 2.5)
                }
        }
    }
    
    func delayedStopActivity() {
        stopAnimating()
    }
}

