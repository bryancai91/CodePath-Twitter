//
//  TweetCell.swift
//  CodePath-Twitter
//
//  Created by Bryan Cai on 2/25/16.
//  Copyright © 2016 Bryan Cai. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
	
	
	@IBOutlet weak var tweetImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var bodyLabel: UILabel!
	@IBOutlet weak var timestampLabel: UILabel!
	
	var tweet: Tweet! {
		didSet {
			nameLabel.text = tweet.user?.name
			tweetImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
			bodyLabel.text = tweet.text
			
			let dateFormatter = NSDateFormatter()
			dateFormatter.dateStyle = .ShortStyle
			let timestampString = dateFormatter.stringFromDate(tweet.timestamp!)
			timestampLabel.text = timestampString
		}
	}
	
	// not sure if you can put the tapGestureRecognizer in here
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		tweetImageView.layer.cornerRadius = 3
		tweetImageView.clipsToBounds = true
		nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
	}
	

	override func layoutSubviews() {
		super.layoutSubviews()
		nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}

	
}
