//
//  Request.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


struct Request {
    
    enum MethodType: String { case POST, GET, DELETE }
    
    //TODO: Change to reflect new Heroku URL
    let base = "https://officehawk.herokuapp.com"
    
    var endPoint: String!
    var methodType: MethodType = .GET
    var parameters: [String:AnyObject] = [:]
    var headers: [String : String]?
    var url: String {
        return base + self.endPoint
    }
}
