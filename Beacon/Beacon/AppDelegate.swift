//
//  AppDelegate.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import Timepiece
import RealmSwift
import KeychainSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?
   
    // beacon manager
    let beaconManager = ESTBeaconManager()
    
    //Regions
    let hulk = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: _UUIDString)!, major: Beacon.Hulk.major, minor: Beacon.Hulk.minor, identifier: "Front Door")
    
    let manhattan = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: _UUIDString)!, major: Beacon.Manhattan.major, minor: Beacon.Manhattan.minor, identifier: "Kitchen")
    
    let wonder = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: _UUIDString)!, major: Beacon.Wonder.major, minor: Beacon.Wonder.minor, identifier: "Ping-Pong Table")
    


    // Add the property holding the data.
    // TODO: replace "<major>:<minor>" strings to match your own beacons
    let _placesByBeacons = [
        "100:1000": [
            "Front Door": 1,
            // read as: it's 5 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            "Bathroom": 5,
            "Kitchen": 10,
            "Ping-Pong-Table": 15
        ],
        "200:1001": [
            "Front Door": 5,
            "Bathroom": 5,
            "Kitchen": 1,
            "Ping-Pong-Table": 5
        ],
        "300:1002": [
            "Front Door": 15,
            "Bathroom": 10,
            "Kitchen": 5,
            "Ping-Pong-Table": 1
        ]
    ]
    
    
    //Timer
    var timer: NSTimer?
    
    var timerIsRunning = false
    
    //Duration
    var duration: Int = 0 {
        didSet {
            print("Duration: \(duration)")
        }
    }
    
    //Current Region
    var currentRegion: CLBeaconRegion?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        window?.backgroundColor = UIColor.whiteColor()
        
        let k = KeychainSwift()
        if let t = k.get("token") {
            print("token", t)
        }

        
        if NetworkManager.sharedManager().token == emptyString {
           print("token is nil")
            let loginSB = UIStoryboard(name: "Login", bundle: nil)
            if let nav = loginSB.instantiateInitialViewController() as? UINavigationController {
                window?.rootViewController = nav
                print("set login as root")
            }
   
         
        
        } else if NetworkManager.sharedManager().token != "" {
            
            
            print("Found user with token")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let tab = sb.instantiateInitialViewController() as? UITabBarController {
                window?.rootViewController = tab
                print("set main as root")
            }
   
        }
        
        window?.makeKeyAndVisible()
        
        setUpBeaconManager()
        
        return true
    }
    
    
    func setUpBeaconManager() {
        
        //Set Manager Delegate
        self.beaconManager.delegate = self
        
        //Request Authorization
        self.beaconManager.requestAlwaysAuthorization()
        
        //Montior Regions
        guard let _ = NSUUID(UUIDString: _UUIDString) else { return }
        
        let regions = [self.hulk, self.manhattan, self.wonder]
        
        for region in regions {
            self.beaconManager.startMonitoringForRegion(region)
            
            print("monitoring started for region: \(region.identifier)")
            
        }
        
        print("monitoring started")
        
        
        
    }
    
    func startTimer() {
        guard !timerIsRunning else { return }
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTime", userInfo: nil, repeats: true )

        timerIsRunning = true
        
        
    }
    func updateTime() {
        guard timerIsRunning else { return }
        duration++
    }
    
    func stopTimer() {
        guard timerIsRunning else { return }
        timer?.invalidate()
        timer = nil
        duration = 0
    }
    
    //Delegate Method
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        
        //Check if timer is already running
        
        currentRegion = region
        
        
        guard !timerIsRunning else { return }
        
        
        //Get current region
        currentRegion = region
        
        //start timer
        startTimer()
        

        print("Entered New Region: \(region.identifier)")
    }
    

    
    //Exited Region
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        
        //get copy of time
        let time = duration
        
        //check that it's over threshold
        if time >= 60 {
            
            //do rails request
            NetworkManager.sharedManager().checkInWith(region, andDuration: time, completion: { (success) -> () in
                
                //when success, invalidate timer and reset
                if success {
                    print("successfully logged \(self.duration) to user \(NetworkManager.sharedManager().token)")
                    self.stopTimer()
                }
                
            })
            
            
            
        }
        
    
        
    }
    


    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let bgTask = UIBackgroundTaskIdentifier()
       
        application.beginBackgroundTaskWithExpirationHandler { () -> Void in
            //Background
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) { () -> Void in
                guard let r = self.currentRegion else {return }
                NetworkManager.sharedManager().checkInWith(r, andDuration: self.duration, completion: { (success) -> () in
                    if success {
                        print("posted")
                    }
                })
            
            
                
                //Main
                
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    
                }
                
            }
            

        }
        
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func placesNearBeacon(beacon: CLBeacon) -> [String] {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        if let places = self._placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sort { $0.1 < $1.1 }.map { $0.0 }
            return sortedPlaces
        }
        return []
    }

}

