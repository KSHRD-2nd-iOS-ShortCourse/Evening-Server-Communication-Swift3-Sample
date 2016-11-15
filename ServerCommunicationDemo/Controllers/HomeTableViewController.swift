//
//  HomeTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/11/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class HomeTableViewController: UITableViewController {
    
    var books : [JSON]! = [JSON]()
    var coverPhotos : [JSON]! = [JSON]()
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("http://fakerestapi.azurewebsites.net/api/Books").responseJSON { (response) in
            if let data = response.data {
                // JSON Results
                let jsonObject = JSON(data: data)
                self.books = jsonObject.array
                
                Alamofire.request("http://fakerestapi.azurewebsites.net/api/CoverPhotos").responseJSON(completionHandler: { (response) in
                    if let data = response.data{
                        // JSON Results
                        let jsonObject = JSON(data: data)
                        self.coverPhotos = jsonObject.array
                        
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let destView = segue.destination as! DetailTableViewController
            destView.bookId = sender as? String
        }
     }
 
}


// MARK: - Table view data source
extension HomeTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        // Configure the cell...
        
        let book = self.books[indexPath.row]
        let cover = self.coverPhotos[indexPath.row]
        cell.titleLabel.text = book["Title"].stringValue
        cell.descriptionLabel.text = book["Description"].stringValue
        
        //cell.coverImageView.image = UIImage(data: try! Data(contentsOf: URL(string: cover["Url"].stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!))
        cell.coverImageView.kf.setImage(with: URL(string: cover["Url"].stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholder: UIImage(named: "google_logo"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showDetail", sender: books[indexPath.row]["ID"].stringValue)
        
    }
    
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
}
