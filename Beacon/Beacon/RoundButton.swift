//
//  RoundButton.swift
//  SwiftyAlert
//
//  Created by Mac Bellingrath on 11/13/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
@IBDesignable
class RoundButton: UIButton {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
       
        let wider = rect.width > rect.height
        layer.cornerRadius = wider ? rect.height / 2 : rect.width / 2
        layer.masksToBounds = true
        clipsToBounds = true
        
        
    }
    

}
