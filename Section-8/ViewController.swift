/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func addItemButton(sender: AnyObject) {
        
        addObjectToParse(nameTextField.text!, description: descriptionTextField.text!, price: Double(priceTextField.text!)!)
    }
    
    
    func addObjectToParse(objName: String, description: String, price: Double) {
        
        let product = PFObject(className: "Products")
        product["name"] = objName
        product["description"] = description
        product["price"] = price
        
        let item = product["name"]
        product.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if success {
                
                print("item \(item) was saved to parse, with ObjectID \(product.objectId)")
                resultLabel.text = "item \(item) was saved to parse, \n with ObjectID \(product.objectId)"
                
            } else {
                print("there was a problem")
                print(error)
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let query = PFQuery(className: "Products")
//        
//        query.getObjectInBackgroundWithId("NYtDGRaaUl") { (object : PFObject?, error: NSError?) -> Void in
//            
//            if error != nil {
//                
//                print(error?.description)
//                
//            } else if let product = object {
//                
//                
//                product["description"] = "Rocy Road"
//                product["price"] = 5.99
//                
//                product.saveInBackground()
//                
//                print(object)
//                print(object?.objectForKey("description"))
//                
//            }
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
