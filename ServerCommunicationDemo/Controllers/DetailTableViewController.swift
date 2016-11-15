//
//  DetailTableViewController.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/15/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import Kingfisher

class DetailTableViewController: UITableViewController {

    @IBOutlet var coverImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    
    var bookId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = bookId {
            Alamofire.request("http://fakerestapi.azurewebsites.net/api/Books/\(id)").responseObject(completionHandler: { (bookResponse: DataResponse<Book>) in
                
                switch bookResponse.result{
                case .success(let bookData):
                    Alamofire.request("http://fakerestapi.azurewebsites.net/api/CoverPhotos/\(id)").responseObject(completionHandler: { (bookCoverResponse: DataResponse<BookCover>) in
                        switch bookCoverResponse.result{
                        case.success(let bookCoverData):
                            self.titleLabel.text = bookData.title!
                            self.descriptionLabel.text = bookData.description!
                            self.coverImageView.image = UIImage(data: try! Data(contentsOf: URL(string: bookCoverData.url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!))
                        case.failure(let error):
                            print("\(error)")
                        }
                    })
                    
                    
                case.failure(let error):
                    print("\(error)")
                }
                
            })
        }
       
    }

}
