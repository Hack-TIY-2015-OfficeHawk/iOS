//
//  DetailViewController.swift
//  Beacon
//
//  Created by Mac Bellingrath on 11/15/15.
//  Copyright © 2015 Mac Bellingrath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var index = 0
    
    var users = [User(name: "Terri"), User(name: "Dan"), User(name: "HAWK!")]

    @IBOutlet weak var tableView: UITableView!
    
    var entries = ["Ping Pong" , "Desk" , "Kitchen" ]
     var times = ["22 Minutes on Tuesday", "3 hours on Tuesday afternoon", "18 minutes this morning"]
    
    @IBOutlet weak var greetingTextLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureView()
    }
    
    func configureView() {
        let user = users[index]
        let image = UIImage(named: user.name)
        self.greetingTextLabel.text = "Here is the log for \(user.name). "
        self.profileImageView.image = image
        self.profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.clipsToBounds = true
        tableView.reloadData()
    
        
    }
    
    //tableview
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
       
        cell.textLabel?.text = entries[indexPath.row]
        cell.detailTextLabel?.text = times[indexPath.row]
        cell.textLabel?.textColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1)
        cell.detailTextLabel?.textColor = UIColor(red:0.65, green:0.65, blue:0.65, alpha:1)
    
        
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
