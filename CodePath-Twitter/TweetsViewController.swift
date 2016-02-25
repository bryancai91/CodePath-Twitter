//
//  TweetsViewController.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/18/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	var tweets: [Tweet]!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 120
		
		
		TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
			self.tweets = tweets
			self.tableView.reloadData()

//			for tweet in tweets {
//				print(tweet.text)
//			}
			}, failure: { (error: NSError) -> () in
				print(error.localizedDescription)
			})
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if tweets != nil {
			return 20
		}
		else {
			return 0
		}
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
		cell.tweet = tweets[indexPath.row]
		return cell
	}
	
	@IBAction func onLogout(sender: AnyObject) {
		TwitterClient.sharedInstance.logout()
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
