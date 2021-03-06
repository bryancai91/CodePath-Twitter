//
//  User.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/18/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class User: NSObject {
	
	static let userDidLogoutNotification = "UserDidLogout"
	
	var name: String?
	var screenname: String?
	var profileImageUrl: NSURL?
	var tagline: String?
	var profileBackgroundImageUrl: NSURL?
	var numTweets: Int?
	var numFollowers: Int?
	var numFollowings: Int?
	
	var dictionary: NSDictionary?
	
	init(dictionary: NSDictionary) {
		self.dictionary = dictionary
		
		name = dictionary["name"] as? String
		screenname = dictionary["screen_name"] as? String
		let profileUrlString = dictionary["profile_image_url_https"] as? String
		if let profileUrlString = profileUrlString {
			profileImageUrl = NSURL(string: profileUrlString)
		}
		let profileBackgroundUrlString = dictionary["profile_background_image_url_https"] as? String
		if let profileBackgroundUrlString = profileBackgroundUrlString {
			profileBackgroundImageUrl = NSURL(string: profileBackgroundUrlString)
		}
		tagline = dictionary["description"] as? String
		numTweets = dictionary["statuses_count"] as? Int
		numFollowers = dictionary["followers_count"] as? Int
		numFollowings = dictionary["friends_count"] as? Int
	}
	
	static var _currentUser: User?
	
	class var currentUser: User? {
		get {
		if  _currentUser == nil {
		
		let defaults = NSUserDefaults.standardUserDefaults()
		let userData = defaults.objectForKey("currentUserData") as? NSData
		if let userData = userData {
		let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
		_currentUser = User(dictionary: dictionary)
		}
		}
		return _currentUser
		}
		
		set(user) {
			let defaults = NSUserDefaults.standardUserDefaults()
			
			if let user = user {
				let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
				defaults.setObject(data, forKey: "currentUserData")
			} else {
				defaults.setObject(nil, forKey: "currentUserData")
			}
			defaults.synchronize()
		}
	}
}






