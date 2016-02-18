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
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
}
