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
import NVActivityIndicatorView

class DetailTableViewController: UITableViewController, NVActivityIndicatorViewable {

    @IBOutlet var coverImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    
    var bookId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = CGSize(width: 30, height:30)
        
        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType.ballBeat)
        
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
                            self.tableView.reloadData()
                            self.stopAnimating()
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            let height = self.heightForText(textView: self.descriptionLabel)
            return height < 56 ? 56 : height + 30
        }else{
            return 56
        }
    }
    
    func heightForText(textView: UILabel) -> CGFloat {
        textView.numberOfLines = 0
        textView.sizeToFit()
        return textView.frame.size.height
    }

}
