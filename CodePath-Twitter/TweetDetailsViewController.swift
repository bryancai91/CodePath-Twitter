//
//  TweetDetailsViewController.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/25/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
	
	@IBOutlet weak var tweetDetailsImageView: UIImageView!
	@IBOutlet weak var tweetDetailsNameLabel: UILabel!
	@IBOutlet weak var tweetDetailsScreenameLabel: UILabel!
	@IBOutlet weak var tweetDetailsTextLabel: UILabel!
	@IBOutlet weak var tweetDetailsTimestamp: UILabel!
	@IBOutlet weak var retweetNumLabel: UILabel!
	@IBOutlet weak var favoriteNumLabel: UILabel!
	@IBOutlet weak var replyImageView: UIImageView!
	@IBOutlet weak var retweetImageView: UIImageView!
	@IBOutlet weak var favoriteImageView: UIImageView!
	
	var tweet: Tweet!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tweetDetailsNameLabel.text = tweet.user?.name
		tweetDetailsImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
		tweetDetailsTextLabel.text = tweet.text
		tweetDetailsScreenameLabel.text = tweet.user?.screenname
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateStyle = .ShortStyle
		let timestampString = dateFormatter.stringFromDate(tweet.timestamp!)
		tweetDetailsTimestamp.text = timestampString
		retweetNumLabel.text = String(tweet.retweetCount)
		favoriteNumLabel.text = String(tweet.favoritesCount)
		retweetImageView.image = UIImage(named: "retweet-action")
		favoriteImageView.image = UIImage(named: "like-action")
		replyImageView.image = UIImage(named: "reply-action_0")
		
		let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
//		tapGestureRecognizer.cancelsTouchesInView = true
//		tapGestureRecognizer.delegate = self
		replyImageView.userInteractionEnabled = true
		replyImageView.addGestureRecognizer(tapGestureRecognizer)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func imageTapped(sender: UITapGestureRecognizer) {
		self.performSegueWithIdentifier("pushToReply", sender: sender)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "pushToReply" {
			let composeViewController = segue.destinationViewController as! ComposeViewController
			composeViewController.user = tweet.user
			composeViewController.isThisAReply = true
		}
	}
	
}
