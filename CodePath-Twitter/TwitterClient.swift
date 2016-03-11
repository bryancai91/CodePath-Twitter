//
//  TwitterClient.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/16/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "1wlWWsbl1iAT87dM4YPi5bwzD"
let twitterConsumerSecret = "bA33ZMXKGmaeguSvf3byTjZyIQWVEx9fuZlXUr3QoXlGu5dWhV"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")



class TwitterClient: BDBOAuth1SessionManager {
		
	var loginSuccess: (() -> ())?
	var loginFailure: ((NSError) -> ())?
	
	class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
	
	func login(success: () -> (), failure: (NSError) -> ()) {
		
		loginSuccess = success
		loginFailure = failure
		
		// not sure if you need this
		TwitterClient.sharedInstance.deauthorize()
		TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
			//            print("Got the request token")
			
			let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
			UIApplication.sharedApplication().openURL(authURL!)
			
			}) { (error: NSError!) -> Void in
				print("Error getting the request token: \(error)")
				self.loginFailure?(error)
		}
	}
	
	func handleOpenUrl(url: NSURL) {
		
		fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
//			print("Got the access token!")
			
			self.currentAccount({ (user: User) -> () in
				User.currentUser = user
				self.loginSuccess?()
				}, failure: { (error: NSError) -> () in
					self.loginFailure?(error)
				})
			
//			client.requestSerializer.saveAccessToken(accessToken)
//			client.currentAccount()
			
			}) { (error: NSError!) -> Void in
				print("error: \(error.localizedDescription)")
				self.loginFailure?(error)
		}
	}
	
	func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
		
		GET("1.1/statuses/home_timeline.json", parameters: nil,progress: nil, success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
			// print("home timeline: \(response)")
			
			let dictionaries = response as! [NSDictionary]
			let tweets = Tweet.tweetsWithArray(dictionaries)
			
			success(tweets)
			
			}, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
				failure(error)
		})
	}
	
	func currentAccount(success: (User) -> (), failure: (NSError) -> ()) {
		GET("1.1/account/verify_credentials.json", parameters: nil, progress:nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
			// print("user: \(response)")
			
			let user = User(dictionary: response as! NSDictionary)
			
			success(user)
			
			}, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
				failure(error)
		})
	}
	
//	func composeTweet(success: () -> (), failure: (NSError) -> ()) {
//		
//		
//		POST(<#T##URLString: String##String#>, parameters: <#T##AnyObject?#>, progress: <#T##((NSProgress) -> Void)?##((NSProgress) -> Void)?##(NSProgress) -> Void#>, success: <#T##((NSURLSessionDataTask, AnyObject?) -> Void)?##((NSURLSessionDataTask, AnyObject?) -> Void)?##(NSURLSessionDataTask, AnyObject?) -> Void#>, failure: <#T##((NSURLSessionDataTask?, NSError) -> Void)?##((NSURLSessionDataTask?, NSError) -> Void)?##(NSURLSessionDataTask?, NSError) -> Void#>)
//		
//		POST("1.1/statuses/update.json", parameters: nil,progress: nil, success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
//			
//			let dictionaries = response as! [NSDictionary]
//			let tweets = Tweet.tweetsWithArray(dictionaries)}
//			
//			success()
//			
//			
//			}, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
//				failure(error)
//		})
//	}
	
	func logout() {
		User.currentUser = nil
		deauthorize()
		
		NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
	}
	
}
