//
//  HBAccuracyView.swift
//  HuntyBeacon
//
//  Created by Mac Bellingrath on 11/10/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

@IBDesignable
class HBAccuracyView: UIView {
    
    var beaconColor
    = UIColor.lightGrayColor() {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        
        beaconColor.set()

        let insetRect = CGRectInset(rect, 1, 1)
        
        //Stroke Oval Path
        CGContextStrokeEllipseInRect(context, insetRect)
        
    }
    

}
