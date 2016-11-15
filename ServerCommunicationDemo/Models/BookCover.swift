//
//  BookCover.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/15/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import Foundation
import ObjectMapper

class BookCover: Mappable {
    var id: Int?
    var idBook: Int?
    var url: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id      <- map["ID"]
        idBook  <- map["IDBook"]
        url     <- map["Url"]
    }
}
