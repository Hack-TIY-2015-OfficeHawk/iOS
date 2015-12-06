//
//  Networking.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Timepiece
import RealmSwift
import KeychainSwift
import ObjectMapper
import AlamofireObjectMapper

private let _nm = NetworkManager()
private let _d = NSUserDefaults.standardUserDefaults()

class NetworkManager: NSObject {
    
    enum NetworkError: ErrorType {
        case Error
    }
    
    class func sharedManager() -> NetworkManager { return _nm }
    
    var token: String? {
        get { return _d.objectForKey("token") as? String }
        set { _d.setObject(newValue, forKey: "token") }
    }
    
    
    
    /**
     Login Function
     
     - parameter un:      User's username
     - parameter pw:      User's password
     - parameter success: Returns true on successful network operation, false with error.
     */
    func login(un: String, pw: String, success: (Bool) -> ()) {
        
        var info = Request()
        info.endPoint = "/employees/login"
        info.methodType = .POST
        
        info.parameters = [
            "username" : un,
            "password"  : pw
        ]
        
        //Create Alamofire Request
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (response) -> Void in
            
            //Switch on response's result
            switch response.result {
                
            case .Failure(let error):
                success(false)
                SweetAlert().showAlert("Something went wrong.", subTitle: "We're sorry but we couldn't log you in. Please try again", style: AlertStyle.Error, buttonTitle: "OK")
                print(error)
            case .Success(let value):
                
                print("login succeeded: \(value)")
                    
                let json = JSON(value)
                let token = json["auth_token"].stringValue
                self.token = token
                success(true)
                    
            }
        }
    }
    

    
    func register(teamName: String, un: String, pw: String, success: (Bool) -> ()) {
        
        var info = Request()
        info.endPoint = "/organizations"
        info.methodType = .POST
        
        info.parameters = [
            "name": teamName,
            "username" : un,
            "password"  : pw
        ]
        
        //Create Alamofire Request
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: ParameterEncoding.JSON, headers: nil).responseObject { (response: Response<CurrentUser, NSError >) -> Void in
            if let currentUser = response.result.value {
                    let token = currentUser.token
                    let keychain = KeychainSwift()
                
                    keychain.set(token, forKey: "token")
                
                success(true)
               

            } else {
                 SweetAlert().showAlert("Something went wrong.", subTitle: "We're sorry but we couldn't sign you up. Please try again", style: AlertStyle.Error, buttonTitle: "OK")
                success(false)
            }
        }
            
    }
//            responseJSON(options: NSJSONReadingOptions.MutableContainers) { (response) -> Void in
//            
//            //Switch on response's result
//            switch response.result {
//                
//            case .Failure(let error):
//                success(false)
//                SweetAlert().showAlert("Something went wrong.", subTitle: "We're sorry but we couldn't sign you up. Please try again", style: AlertStyle.Error, buttonTitle: "OK")
//                print(error)
//            case .Success(let value):
//                
//                print("Registration succeeded: \(value)")
//                
//                if let jsonDict = value as? [String: AnyObject] {
//                    let json = JSON(jsonDict)
//                    print(json)
//                
//                     success(true)
//                    
//                }
//                
//            }
//        }
    


    /**
     Logs current user out
     */
    func logOut() {
        
    NetworkManager.sharedManager().token = nil
        SweetAlert().showAlert("Are You sure", subTitle: "Would you like to log out?", style: AlertStyle.Warning, buttonTitle: "Yes") { (isOtherButton) -> Void in
            let  keychain = KeychainSwift()
            keychain.clear()
            UIApplication.sharedApplication().presentLoginFlow(UIApplication.sharedApplication().windows.first!)


            }
        
    }
    
    
    /**
     Register a Beacon
    
     */
    func checkInWith(region: CLBeaconRegion, andDuration duration: Int, completion: (Bool) -> ()) {
        
        
        
        //get major and minor
        guard let major = region.major else { return completion(false) }
        guard let minor = region.minor else { return completion(false) }
     
        var info = Request()
        info.endPoint = "/alerts"
        
        //uuid
        //major
        //minor
        //state
        //duration
        
        
        info.parameters = [
            "uuid": _UUIDString,
            "major" : Int(major),
            "minor" : Int(minor),
            "state" : "near",
            "duration" : duration
            
            
            
        
        ]
        
        if let token = NetworkManager.sharedManager().token {
            info.headers = [
                "auth-token": token
            ]
        }
        
        //Create Alamofire Request
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: ParameterEncoding.JSON, headers: info.headers).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (response) -> Void in
            
            //Switch on response's result
            switch response.result {
                
            case .Failure(let error):
                completion(false)
                SweetAlert().showAlert("Something went wrong.", subTitle: "We're sorry but we couldn't log you in. Please try again", style: AlertStyle.Error, buttonTitle: "OK")
                print(error)
            case .Success(let value):
                completion(true)
                print("login succeeded: \(value)")
            }
        }
    }
    

    
    
    func postAlertWithTime(time: NSTimeInterval, completion: (success: Bool) -> Void ) {
        
        var info = Request()
        info.endPoint = "/login"
        info.methodType = .POST
        
        info.parameters = ["":""
        ]
        
        if let token = NetworkManager.sharedManager().token {

        info.headers = [
            "auth-token": token
            ]
        }
        
        //Create Alamofire Request
        Alamofire.request(.POST, info.url, parameters: info.parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (response) -> Void in
            
            //Switch on response's result
            switch response.result {
                
            case .Failure(let error):
                completion(success: false)
                SweetAlert().showAlert("Something went wrong.", subTitle: "We're sorry but we couldn't log you in. Please try again", style: AlertStyle.Error, buttonTitle: "OK")
                print(error)
            case .Success(let value):
                completion(success: true)
                print("login succeeded: \(value)")
            }
        }
    }
}




