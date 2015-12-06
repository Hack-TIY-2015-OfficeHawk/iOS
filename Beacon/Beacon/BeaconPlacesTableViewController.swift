//
//  BeaconPlacesTableViewController.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class BeaconPlacesTableViewController: UITableViewController, ESTBeaconManagerDelegate {
    
    //Places
    
    var sortedPlaces: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // Beacon Manager
    let beaconManager = ESTBeaconManager()
    
    //Region
    let beaconRegion = CLBeaconRegion(
        proximityUUID: NSUUID(UUIDString: _UUIDString)!,
        identifier: "ranged region")
    
    
    // Add the property holding the data.
    // TODO: replace "<major>:<minor>" strings to match your own beacons
    let placesByBeacons = [
        "100:1000": [
            "Desk": 1,
            // read as: it's 5 meters from
            // "Heavenly Sandwiches" to the beacon with
            // major 6574 and minor 54631
            
            "Kitchen": 10,
            "Ping-Pong-Table": 15
        ],
        "200:1001": [
            "Desk": 5,
            "Kitchen": 1,
            "Ping-Pong-Table": 5
        ],
        "300:1002": [
            "Desk": 15,
            "Kitchen": 5,
            "Ping-Pong-Table": 1
        ]
    ]

    func placesNearBeacon(beacon: CLBeacon) -> [String] {
        let beaconKey = "\(beacon.major):\(beacon.minor)"
        if let places = self.placesByBeacons[beaconKey] {
            let sortedPlaces = Array(places).sort { $0.1 < $1.1 }.map { $0.0 }
            self.sortedPlaces = sortedPlaces
            return sortedPlaces
        }
        return []
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        if NetworkManager.sharedManager().token != nil {
//            useTouchID("Please login using fingerprint") { (success, messageState, errorResult) -> Void in
//                print(messageState)
//                
//                if success {
//                    
//                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                        
//                        SweetAlert().showAlert("Welcome", subTitle: "We're glad you're back.", style: AlertStyle.Success)
//                        
//                        self.performSegueWithIdentifier("showMain", sender: self.navigationController)
//                        
//                        
//                    })
//                }
//            }
//        }
        
        // Set Beacon Manager Delegate
        self.beaconManager.delegate = self
        
        // Request Auth
        self.beaconManager.requestAlwaysAuthorization()
      
        
       

    }
    /**
     Start montioring when view appears
     
     - parameter animated: pass 'YES' to animate view
     */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.beaconManager.startRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    /**
     Stop monitoring for region when view disappears
     
     - parameter animated: Yes to animate view
     */
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.beaconManager.stopRangingBeaconsInRegion(self.beaconRegion)
    }
    
    
    
    //MARK:MANAGER DELEGATE
    
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if let nearestBeacon = beacons.first {
            let places = placesNearBeacon(nearestBeacon)
            // TODO: update the UI here
            print(places) // TODO: remove after implementing the UI
        }
    }
    
    //TABLEVIEW
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let place = sortedPlaces[indexPath.row]
        cell.textLabel?.text = place
        guard let image = UIImage(named: place) else { return cell }
        cell.imageView?.image = image
        cell.textLabel?.textColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        return cell
        
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPlaces.count
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
