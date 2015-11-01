//
//  ViewController.swift
//  Parse Demo
//
//  Created by Jorge Bastos on 10/20/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    // MARK: - Image
    
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func importImage(sender: AnyObject) {
        
        resultLabel.hidden = true
        resultTextView.hidden = true
        imageView.hidden = false
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        print("Image Selected")
        
        // dismiss pickercontroller
        self.dismissViewControllerAnimated(true, completion: nil)
        
        imageView.image = image
    }
    
    
    @IBAction func pauseButton(sender: AnyObject) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // ignore user inputs while activity indicator is spinning
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    
    @IBAction func restoreButton(sender: AnyObject) {
        
        activityIndicator.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    @IBAction func alertButton(sender: AnyObject) {
        
        let alert = UIAlertController(title: "Hey there!", message: "Are you sure", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action: UIAlertAction) -> Void in
            
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    // end Image
    
    // MARK: - Parse
    
    let parseEntity = "Products"
    var resultText: String = ""
    var timer = NSTimer()
    
    // MARK: - IBOutlet/IBAction

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var itemIdTextField: UITextField!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var switchLabel: UISwitch!
    
 
    
    
    @IBAction func switchView(sender: AnyObject) {
        
        swithCheck()
        
     }
    
    
    @IBAction func addItemButton(sender: AnyObject) {
        
        
        if nameTextField.text != nil && descriptionTextField.text != nil && priceTextField.text != nil {
        
            saveObject(nameTextField.text!, description: descriptionTextField.text!, price: Double(priceTextField.text!)!)
            
        }
        
    }
    
    
    @IBAction func editItemButton(sender: AnyObject) {
    }
    

    @IBAction func trashItemButton(sender: AnyObject) {
    }
    
    
    @IBAction func seachItemButton(sender: AnyObject) {
        
        if itemIdTextField.text != "" && nameTextField.text == "" && descriptionTextField.text == "" && priceTextField.text == "" {
        print(itemIdTextField.text)
        retreiveObjectBy(itemIdTextField.text!)
            
        } else if itemIdTextField.text == "" && nameTextField.text != "" && descriptionTextField.text == "" && priceTextField.text == "" {
            
            searchForObject("name", item: nameTextField.text!)
            
        } else if itemIdTextField.text == "" && nameTextField.text == "" && descriptionTextField.text != "" && priceTextField.text == "" {
            
            searchForObject("description", item: descriptionTextField.text!)
            
        } else if itemIdTextField.text == "" && nameTextField.text == "" && descriptionTextField.text == "" && priceTextField.text != "" {
            
            searchForObject("price", item: Double(priceTextField.text!)!)
        }
        clearLabels()
    }
    
    
    func swithCheck() {
        
        imageView.hidden = true
        
        if switchLabel.on {
            
            resultLabel.hidden = true
            resultTextView.hidden = false
            resultTextView.text = resultText
            
        } else {
            
            resultTextView.hidden = true
            resultLabel.hidden = false
            resultLabel.text = resultText
        }

    }
    
    
    func clearLabels() {
        
        nameTextField.text = ""
        descriptionTextField.text = ""
        priceTextField.text = ""
        resultLabel.text = ""
        
    }
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        swithCheck()
        
        //searchForObject("price", object: 6.0)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Parse
    
    func saveObject(name: String, description: String, price: Double) {
        
        let newItem = PFObject(className: "Products")
        
        newItem["name"] = name
        newItem["description"] = description
        newItem["price"] = price
        
        newItem.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            if success {
                let item = newItem["name"]
                self.resultText = "Successfully saved to Parse: \n item: \(item) with Id: \(newItem.objectId)"
                print("Successfully saved to Parse: \n item: \(item) with Id: \(newItem.objectId!)")
                
            } else {
                self.resultText = "\(error?.description)"
                print(error?.description)
            }
            
            self.swithCheck()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("clearLabels"), userInfo: nil, repeats: false)
        }
    }
    
    func retreiveObjectBy(Id: String) {
        let query = PFQuery(className: "Products")
        query.getObjectInBackgroundWithId(Id) { (object: PFObject?, error: NSError?) -> Void in
            
            if error == nil && object != nil {
                
                print(object!)
                
                let name = object!["name"]
                let description = object!["description"]
                let price = object!["price"]
                
                
                self.resultText = "Query returned: \n\n\t\(object!.objectId!) - \(name) \n\t\(description) \(price)\n"
            }
            
            self.swithCheck()
            
        }
    }
    
    
    func searchForObject(key: String, item: AnyObject) {
        
        let query = PFQuery(className: "Products")
        
        query.whereKey(key, equalTo: item)
        
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                
                self.resultText = "Successfully retreived \(objects!.count):\n"
                print("Successfully retreived \(objects!.count)")
                
                var itemNumber = 0
                
                if let objects = objects {
                    
                    for object in objects {
                        
                        let name = object["name"]
                        let description = object["description"]
                        let price = object["price"]
                        
                        itemNumber++
                        
                        self.resultText += "\t\(itemNumber)-> \(object.objectId!) - \(name) \n\t      \(description) \(price)\n"
                        print("\(object.objectId!) - \(name) \n \(description) \(price)\n" )
                    }
                    
                }
                
            } else {
                
                print("Error: \(error!) \(error!.userInfo)")
            }
            
            self.swithCheck()
        }
    }
    
    func updateObjectWhitId(id: String) {
        
        let query = PFQuery(className: "Products")
        
        query.getObjectInBackgroundWithId(id) { (object: PFObject?, error: NSError?) -> Void in
            
            
            if error == nil && object != nil {
                
                print(object)
                
                if let object = object {
                    
                    object["description"] = "Mozzarella"
                    
                    object.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                        print(success, error)
                        
                        if success && error == nil {
                            
                            print("object successfuly saved")
                            self.retreiveObjectBy(id)
                            
                        } else {
                            print(error)
                        }
                        
                    })
                    
                }
                
            } else {
                
                print(error!.description)
                
            }
            
        }
    }
    
    
} // eof


















