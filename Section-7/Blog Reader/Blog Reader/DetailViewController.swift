//
//  DetailViewController.swift
//  Blog Reader
//
//  Created by Jorge Bastos on 10/19/15.
//  Copyright © 2015 Jorge Bastos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var webview: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let postWebview = self.webview {
                
                postWebview.loadHTMLString(detail.valueForKey("content")!.description, baseURL: NSURL(string: "https://googleblog.blogspot.com.br")!)
//                label.text = detail.valueForKey("content")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

