//
//  Book.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/15/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import Foundation
import ObjectMapper

class Book: Mappable {
    var id: Int?
    var title: String?
    var description: String?
    var pageCount : Int?
    var excerpt : String?
    var publishDate: String?
    var bookCover: BookCover?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["ID"]
        title       <- map["Title"]
        description <- map["Description"]
        pageCount   <- map["PageCount"]
        excerpt     <- map["Excerpt"]
        publishDate <- map["PublishDate"]
    }
}
