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
    
    // Property
    var book : [String : Any]?
    let imagePicker = UIImagePickerController()
    
    // Outlet
    @IBOutlet var descriptionLabel: UITextField!
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var coverImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if book is not nil, assign value to outlet
        if let book = book{
            titleLabel.text = book["Title"] as! String?
            descriptionLabel.text = book["Description"] as! String?
        }
        
        // set delegate for imagePicker
        imagePicker.delegate = self
    }
    
    // TODO: Save Action
    @IBAction func save(_ sender: Any) {
        
        // Create NVActivityIndicator
        let size = CGSize(width: 30, height:30)
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballBeat)
        
        /***** NSDateFormatter Part *****/
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dayTimePeriodFormatter.string(from: Date())
        
        // dateString now contains the string:
        // "December 25, 2016 at 7:00:00 AM"
        print(dateString)
        
        let paramater = [
            "Title": titleLabel.text!,
            "Description": descriptionLabel.text!,
            "PageCount": 0,
            "Excerpt": "string",
            "PublishDate": dateString
            ] as [String : Any]
        
        var url = DataManager.Url.BOOK
        var method = HTTPMethod.post
        
        // if have book data > update
        if book != nil  {
            url = "\(DataManager.Url.BOOK)/\(book!["ID"]!)"
            method = HTTPMethod.put
        }
        
        // request
        Alamofire.request(url,
                          method: method,
                          parameters: paramater,
                          encoding: JSONEncoding.default,
                          headers: DataManager.Url.HEADERS)
            .responseJSON { (response) in
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

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension AddEditInfoTableViewController {
    
    // TODO: Browse Image IBAction
    @IBAction func browseImage(_ sender: Any) {
        // coonfig property
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        // show image picker
        present(imagePicker, animated: true, completion: nil)
    }
    
    // TODO: Finish Picking Media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        // Get image
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            // config property and assign image
            coverImageView.contentMode = .scaleAspectFit
            coverImageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: Image Picker Controller Did Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // TODO: Take Photo
    @IBAction func openCameraButton(sender: AnyObject) {
        
        // config property
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // TODO: Image Picker Did Finish Picking Image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        // Set image to coverImageView
        coverImageView.image = image
        self.dismiss(animated: true, completion: nil);
    }

}
