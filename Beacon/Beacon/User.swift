//
//  User.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import RealmSwift
import KeychainSwift
import ObjectMapper


class User: NSObject {
    
    var name: String = "Employee"
    var isManager = false
    var location: CLBeaconRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: _UUIDString)!, identifier: "Ping-Pong")
    //Def Users
    var image: UIImage?
    
    
    init(name: String) {
        self.name = name
        
    }
}


class CurrentUser: Object, Mappable {
   
    dynamic var token = ""
    dynamic var username = ""
    dynamic var password = ""
    dynamic var organizationName = ""
    dynamic var id = 0
    dynamic var owner = ""
    var isCurrent: String?
    override class func primaryKey() -> String? {
        return "isCurrent"
    }
    
    
    required convenience init?(_ map: Map) {
        self.init()
        
    }
    
    // Mappable
    func mapping(map: Map) {
        token               <- map["auth_token"]
        organizationName    <- map["organization.name"]
        id      <- map["organization.id"]
        owner       <- map["organization.owner"]
    }
    
}


