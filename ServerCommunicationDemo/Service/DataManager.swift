//
//  DataManager.swift
//  ServerCommunicationDemo
//
//  Created by Kokpheng on 11/18/16.
//  Copyright © 2016 Kokpheng. All rights reserved.
//

import Foundation

struct DataManager {
    struct Url {
        // Define url
        static let BASE = "http://fakerestapi.azurewebsites.net/"
        static let BOOK = BASE + "api/Books"
        static let AUTHOR = BASE + "api/Authors"
        static let COVER = BASE + "api/CoverPhotos"
        static let USER = BASE + "api/Users"
        
        // Define header
        static let HEADERS = [
            "Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
    }
}




