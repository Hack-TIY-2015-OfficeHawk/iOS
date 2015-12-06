//
//  Extensions.swift
//  HuntyBeacon
//
//  Created by Mac Bellingrath on 11/10/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

let estimoteGreen = UIColor(red:0.69, green:0.82, blue:0.7, alpha:1)
let estimoteBlue = UIColor(red:0.69, green:0.83, blue:0.9, alpha:1)
let estimotePurple = UIColor(red:0.31, green:0.28, blue:0.52, alpha:1)



////////////
////////////
////////////
let emptyString = ""
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension UIViewController {
   
    func presentMainFlow() {
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = mainsb.instantiateInitialViewController() as? UITabBarController {
            UIApplication.sharedApplication().windows.first?.rootViewController = tabBarVC
//            self.navigationController?.pushViewController(tabBarVC, animated: true)
        }
    }
}


extension UIApplication {
    
    
    
    func presentLoginFlow(var window: UIWindow) -> Bool {
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        let loginSB = UIStoryboard(name: "Login", bundle: nil)
        if let nav = loginSB.instantiateInitialViewController() as? UINavigationController {
            UIApplication.sharedApplication().windows.first?.rootViewController = nav
        }
        return true
    }
    
    func setMainToRootVC(var window: UIWindow) {
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        let mainsb = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = mainsb.instantiateInitialViewController() as? UITabBarController {
        window.rootViewController  = tabBarVC
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        }
    }
}

extension NetworkManager {
   
    class func deviceHasToken() -> Bool {
        if NetworkManager.sharedManager().token != nil {
            return true
        }
            return false
    }
}

