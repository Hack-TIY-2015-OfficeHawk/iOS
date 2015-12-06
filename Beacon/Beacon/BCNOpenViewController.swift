//
//  BCNOpenViewController.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit


class HBViewController: UIViewController, ESTBeaconManagerDelegate {
    
    let beaconManager = ESTBeaconManager()
    
    @IBOutlet weak var beaconProximityLabel: UILabel!
    
    @IBOutlet weak var accuracyView: HBAccuracyView!
    
    @IBOutlet weak var beaconImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        beaconManager.delegate = self
        
        self.beaconManager.requestAlwaysAuthorization()
        
        if let nsuuid = NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D") {
            
            let region = CLBeaconRegion(proximityUUID: nsuuid, identifier: "beacons")
            
            beaconManager.startRangingBeaconsInRegion(region)
        }
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - ESTBeaconManagerDelegate
    
    func beaconManager(manager: AnyObject, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        //statuschanged
    }
    func beaconManager(manager: AnyObject, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
        guard let beacon = beacons.first else { return }
        
        print(beacon.major , beacon.major, beacon.accuracy)
        
        let color = Beacon(rawValue: beacon.major)?.color() ?? UIColor.lightGrayColor()
        
        beaconProximityLabel.textColor = color
        accuracyView.beaconColor = color
        
        guard let img = Beacon(rawValue: beacon.major)!.image else { return }
        beaconImageView.image = img
        
    }
}
