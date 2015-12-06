//
//  BCNTableViewCell.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class BCNTableViewCell: UITableViewCell {

    
    

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLocationLabel: UILabel!
    @IBOutlet weak var userTimeLabel: UILabel!
    
    @IBOutlet weak var isAdminLabel: UILabel!
    
    @IBOutlet weak var locationImageView: UIImageView!
    
    
    override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        var wider = profileImageView.frame.width > profileImageView.frame.height
        
        profileImageView.layer.cornerRadius = wider ? profileImageView.frame.height / 2 : profileImageView.frame.width / 2
        
    
        

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
