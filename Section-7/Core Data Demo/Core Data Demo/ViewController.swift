//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Jorge Bastos on 10/18/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import CoreData

enum entiUser: String {
    case User = "User"
    case Username = "uesrname"
    case Password = "password"
}

class ViewController: UIViewController {
    
    let appDel : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
   // updateValues, searchValue, removeValues
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userListLabel: UILabel!
    
    @IBAction func updateUserButton(sender: AnyObject) {
        
        if let username = usernameTextField.text {
            if let newUsername = passwordTextField.text {
            updateUser("User", forUsername: username, withNewUsername: newUsername)
            }
        }
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func searchUserButton(sender: AnyObject) {
        
        if let username = usernameTextField.text {
        searchUsers("User", forUsername: username)
            
        }
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func removeUserButton(sender: AnyObject) {
        
        if let username = usernameTextField.text {
        
            removeUser("User", username: username)
            
        }
        
        usernameTextField.text = ""
    }
    
    
    @IBAction func addUserButton(sender: AnyObject) {
        
        if usernameTextField.text != nil && passwordTextField.text != nil {
        
        addNew(username: usernameTextField.text!, andPassword: passwordTextField.text!)
            
        } else {
            print("enter a valide username/password")
        }
        
        usernameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func listUsersButton(sender: AnyObject) {
        
        listUsers("User")
    }
    
    // MARK: - Add
    
    func addNew(username username: String, andPassword: String) {
        
        let contex : NSManagedObjectContext = appDel.managedObjectContext
    
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: contex)
        
        newUser.setValue(username, forKey: "username")
        newUser.setValue(andPassword, forKey: "password")
        
        do {
            
            try contex.save()
            
        } catch {
            
            print("Could not save new user")
            
        }
    }
    
    // MARK: - Remove
    
    func removeUser(name: String, username: String) {
        
        let context : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: name)
        
        request.predicate = NSPredicate(format: "username = %@", username)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    context.deleteObject(result)
                    
                    do {
                        
                        try context.save()
                        
                    } catch {
                        
                        print("Could Not delete")
                    }
                }
            }
            
            
        } catch {
            print("Could Not remove user")
        }
        
    }
    
    // MARK: - List
    
    func listUsers(name: String) {
        
        let contex : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: name)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try contex.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    let username = result.valueForKey("username")!
                    let password = result.valueForKey("password")!
                    print(username)
                    print(password)
                    userListLabel.text = "\(username) \n \(password)"
                }
            }
            
        } catch {
            print("could not fetch")
        }
        
    }
    
    // MARK: - Search
    
    func searchUsers(name: String, forUsername username: String) {
        
        let contex : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: name)
        
        request.predicate = NSPredicate(format: "username = %@", username)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try contex.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.valueForKey("username") as? String {
                        
                        print(username)
                        if let password = result.valueForKey("password") as? String {
                            
                            print(password)
                             userListLabel.text = "\(username) \n \(password)"
                        }
                    }
                }
            }
            
        } catch {
            print("could not fetch")
        }
    }
    
    // MARK: - Update
    
    func updateUser(name: String, forUsername: String, withNewUsername newUsername: String) {
        
        let contex : NSManagedObjectContext = appDel.managedObjectContext
        
        let request = NSFetchRequest(entityName: name)
        
        request.predicate = NSPredicate(format: "username = %@", forUsername)
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try contex.executeFetchRequest(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    if let username = result.valueForKey("username") as? String {
                        
                        result.setValue(newUsername, forKey: "username")
                        
                        do {
                        
                            try contex.save()
                            
                        } catch {
                            
                            print("Could Not Save")
                            
                        }
                        
                        print(username)
                            userListLabel.text = "\(username)"
                    }
                }
            }
            
        } catch {
            print("could not fetch")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

