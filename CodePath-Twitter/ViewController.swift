//
//  ViewController.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/16/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
		
		let client = TwitterClient.sharedInstance
		// where should this go?
		client.requestSerializer.removeAccessToken()
		client.login({ () -> () in
			self.performSegueWithIdentifier("loginSegue", sender: nil)
			}) { (error: NSError) -> () in
				print("Error:\(error.localizedDescription)")
		}
	}
}

