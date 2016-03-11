//
//  ProfileViewController.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/25/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
	
	@IBOutlet weak var headerImageView: UIImageView!
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var userNameLabel: UILabel!
	@IBOutlet weak var screenNameLabel: UILabel!
	@IBOutlet weak var numTweetsLabel: UILabel!
	@IBOutlet weak var numFollowingLabel: UILabel!
	@IBOutlet weak var numFollowersLabel: UILabel!
	
	var user: User!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		headerImageView.setImageWithURL(user.profileBackgroundImageUrl!)
		profileImageView.setImageWithURL(user.profileImageUrl!)
		userNameLabel.text = String(user.name!)
		screenNameLabel.text = String(user.screenname!)
		numTweetsLabel.text = String(user.numTweets!)
		numFollowersLabel.text = String(user.numFollowers!)
		numFollowingLabel.text = String(user.numFollowings!)
		
        // Do any additional setup after loading the view.
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
