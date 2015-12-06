//
//  BCNTableViewController.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/14/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class BCNTableViewController: UITableViewController {
    
    //Array of Users
    var users = [User(name: "Terri"), User(name: "Dan"), User(name: "HAWK!")]

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        
        NetworkManager.sharedManager().logOut()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            // Add your logic here
            self?.tableView.reloadData()
            
            // Do not forget to call dg_stopLoading() at the end
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor(red:0.01, green:0.55, blue:0.45, alpha:1)
)
        tableView.dg_setPullToRefreshBackgroundColor(UIColor(red:0.23, green:0.35, blue:0.35, alpha:1))
        

    }
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! BCNTableViewCell
        
        let user = users[indexPath.row]
    
        
        cell.userNameLabel.text = user.name
        cell.userLocationLabel.text = user.location.identifier

        cell.userTimeLabel.text = "18 minutes"
        let image = UIImage(named: user.name)
        cell.profileImageView.image = image
        cell.locationImageView.image = UIImage(named: user.location.identifier)
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
        cell.profileImageView.layer.masksToBounds = true
        cell.profileImageView.clipsToBounds = true
//        if user.isManager {
//            cell.isAdminLabel.hidden = false
//            
//        } else if !user.isManager {
//            cell.isAdminLabel.hidden = true
//        }
//        
        

        // Configure the cell...
        
        

        return cell
    }

    deinit {
        self.tableView.dg_removePullToRefresh()
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


//     MARK: - Navigation

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let index = tableView.indexPathForSelectedRow {
            if  let dest = segue.destinationViewController as? DetailViewController {
                dest.index = index.row
                print("set index: \(index.row)")
            }
            
        }

    }
    
        

}
