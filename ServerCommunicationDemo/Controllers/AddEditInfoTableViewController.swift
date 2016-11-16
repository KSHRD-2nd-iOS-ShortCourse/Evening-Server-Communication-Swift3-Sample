//
//  AddEditInfoTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/10/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import NVActivityIndicatorView

class AddEditInfoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NVActivityIndicatorViewable {
    
    var book : [String : Any]?
    
    @IBOutlet var descriptionLabel: UITextField!
    @IBOutlet var titleLabel: UITextField!
    
    @IBOutlet var coverImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let book = book{
            titleLabel.text = book["Title"] as! String?
            descriptionLabel.text = book["Description"] as! String?
        }
        
        // set delegate for imagePicker
        imagePicker.delegate = self
    }
    
    @IBAction func browseImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        // show image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            coverImageView.contentMode = .scaleAspectFit
            coverImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Take Photo
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        coverImageView.image = image
        self.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func save(_ sender: Any) {
        let size = CGSize(width: 30, height:30)
        
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballBeat)
        
        /***** NSDateFormatter Part *****/
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateString = dayTimePeriodFormatter.string(from: Date())
        
        //dateString now contains the string:
        //  "December 25, 2016 at 7:00:00 AM"
        print(dateString)
        let paramater = [
            "Title": titleLabel.text!,
            "Description": descriptionLabel.text!,
            "PageCount": 0,
            "Excerpt": "string",
            "PublishDate": dateString
            ] as [String : Any]
        
        var url = "http://fakerestapi.azurewebsites.net/api/Books"
        var method = HTTPMethod.post
        
        if book != nil  {
            url = "http://fakerestapi.azurewebsites.net/api/Books/\(book!["ID"]!)"
            method = HTTPMethod.put
        }
        
        
        Alamofire.request(url, method: method, parameters: paramater, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            self.stopAnimating()
            if response.response?.statusCode == 200 {
                print("\(method) success")
                _ = self.navigationController?.popViewController(animated: true)
            }else{
                print("\(method) false")
            }
        }
    }
}
