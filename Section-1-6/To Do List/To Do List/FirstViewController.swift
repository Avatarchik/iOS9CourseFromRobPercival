//
//  FirstViewController.swift
//  To Do List
//
//  Created by Jorge Bastos on 10/12/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

var toDoLists = [String]()

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var toDoListTable: UITableView!
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = toDoLists[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            toDoLists.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(toDoLists, forKey: "toDoLists")
            toDoListTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if NSUserDefaults.standardUserDefaults().objectForKey("toDoLists") != nil {
            
            toDoLists = NSUserDefaults.standardUserDefaults().objectForKey("toDoLists") as! [String]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        toDoListTable.reloadData()
    }


}

