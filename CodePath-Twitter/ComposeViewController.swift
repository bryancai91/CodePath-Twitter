
//
//  ComposeViewController.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/25/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ComposeViewController: UIViewController {

	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var screenNameLabel: UILabel!
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var tweetTextField: UITextField!
	@IBOutlet weak var tweetButton: UIButton!
	
	var user: User!
	var isThisAReply: Bool!
	var replyID: Int!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		nameLabel.text = user?.name
		screenNameLabel.text = user?.screenname
		profileImageView.setImageWithURL((user?.profileImageUrl)!)
		
		if isThisAReply == true {
			tweetButton.setTitle("Reply", forState: .Normal)
		}
		else {
			tweetButton.setTitle("Tweet", forState: .Normal)
		}
		
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func tweetButtonPressed(sender: AnyObject) {
		
		
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
