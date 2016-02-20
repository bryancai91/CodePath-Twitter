//
//  Tweet.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/18/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class Tweet: NSObject {
	var user: User?
	var text: String?
//	var createdAtString: String?
	var timestamp: NSDate?
	var retweetCount: Int = 0
	var favoritesCount: Int = 0
	
	init(dictionary: NSDictionary) {
		user = User(dictionary: dictionary["user"] as! NSDictionary)
		text = dictionary["text"] as? String
		retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
		favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
		
		let createdAtString = dictionary["created_at"] as? String
		if let createdAtString = createdAtString {
			let formatter = NSDateFormatter()
			formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
			timestamp = formatter.dateFromString(createdAtString)
		}
	}
	
	class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
		var tweets = [Tweet]()
		
		for dictionary in dictionaries {
			tweets.append(Tweet(dictionary: dictionary))
		}
		
		return tweets
		
	}
}
