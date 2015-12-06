//
//  Beacon.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

enum Beacon: NSNumber {
    
    case Hulk = 100, Manhattan = 200, Wonder = 300
    
    var uuid: String { return _UUIDString }

    
    var major: UInt16 {
        switch self {
        case .Hulk: return 100
        case .Manhattan: return 200
        case .Wonder: return 300

            
        }
    }
    
    var minor: UInt16 {
        switch self {
        case .Hulk: return 1000
        case .Manhattan: return 1001
        case .Wonder: return 1002
            
            
        }
        
    }
    
 
    
  
    
    

    func color() -> UIColor {
        
        switch self {
            
        case .Hulk: return estimoteBlue
        case .Manhattan: return estimoteGreen
        case .Wonder: return estimotePurple
            
        }
    }
    
    var image: UIImage? {
        
        switch self {
        case .Hulk: return UIImage(named: "BeaconBlue")
        case .Manhattan: return UIImage(named: "BeaconGreen")
        case .Wonder: return UIImage(named: "BeaconPurple")
        }
    }
    
}












