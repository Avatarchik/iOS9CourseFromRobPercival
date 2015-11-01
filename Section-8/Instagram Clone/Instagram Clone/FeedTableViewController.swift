//
//  FeedTableViewController.swift
//  Instagram Clone
//
//  Created by Jorge Bastos on 10/24/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController {
    
    
    var messages = [String]()
    var usernames = [String]()
    var imageFiles = [PFFile]()
    var users = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    
        
        downloadData()

        
     
    
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usernames.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! FeedTableViewCell

        // Configure the cell...
        
        
        // get images from parse
        imageFiles[indexPath.row].getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
        
            if let downloadedImage = UIImage(data: data!) {
                cell.postedImage.image = downloadedImage
            }
        }
        
        cell.username.text = usernames[indexPath.row]
        cell.message.text = messages[indexPath.row]

        return cell
    }

    // MARK: - Parse
    
    func downloadData() {
        
        
        // check if theres is user logged in
        if PFUser.currentUser() != nil {
            
            // make a query on the users class
            let query = PFUser.query()
            
            // get all the users
            query?.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError? ) -> Void in
                
                if let usersObject = objects {
                    //print("line 93: ", usersObject)
                    self.messages.removeAll(keepCapacity: true)
                    self.users.removeAll(keepCapacity: true)
                    self.imageFiles.removeAll(keepCapacity: true)
                    self.usernames.removeAll(keepCapacity: true)
                    
                    for object in usersObject {
                        
                        if let user = object as? PFUser {
                            self.users[user.objectId!] = user.username!
                            //print("line 134: ",self.users)
                        }
                    }
                }
                
                // Which users current user is following
                let getFollowedUserQuery = PFQuery(className: "followers")
                getFollowedUserQuery.whereKey("follower", equalTo: PFUser.currentUser()!.objectId!)
                
                getFollowedUserQuery.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
                    
                    if let objects = objects {
                        //print("line 147: ", objects)
                        
                        for object in objects {
                            
                            let followedUser = object["following"] as! String
                            //print("line 121: ", followedUser)
                            let query = PFQuery(className: "Post")
                            
                            query.whereKey("userId", equalTo: followedUser)
                            
                            query.findObjectsInBackgroundWithBlock({ (objects: [PFObject]?, error: NSError?) -> Void in
                                
                                if let objects = objects {
                                    //print("line 160: ", objects)
                                    for object in objects {
                                        
                                        self.messages.append(object["message"] as! String)
                                        self.imageFiles.append(object["imageFile"] as! PFFile)
                                        
                                        self.usernames.append(self.users[object["userId"] as! String]!)
                                        
                                        self.tableView.reloadData()
                                    }
                                    
                                }
                                
                            }) // third query
                            
                            
                            
                        }
                    }
                    
                }) // second query
                
                
            }) // first query

            
        }
        
        
        
    } // end of function
    
    
    
    
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

    
} // eof








































