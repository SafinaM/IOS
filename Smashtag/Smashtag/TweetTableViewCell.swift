
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by LinuxPlus on 12/17/17.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit
import Twitter



class TweetTableViewCell: UITableViewCell
{

	@IBOutlet var tweetProfileImageView: UIImageView!
	@IBOutlet var tweetCreatedLabel: UILabel!
	@IBOutlet var tweetUserLabel: UILabel!
	@IBOutlet var tweetTextLabel: UILabel!
	
	var tweet: Twitter.Tweet? {didSet {updateUI() }}
	private func updateUI() {
		tweetTextLabel?.text = tweet?.text
		tweetUserLabel?.text = tweet?.user.description
		
		if let profileImaageUrl = tweet?.user.profileImageURL {
//			FIXME: blocks main thread
			if let imageData = try? Data(contentsOf: profileImaageUrl) {
				tweetProfileImageView?.image = UIImage(data: imageData)
			}
		} else {
			tweetProfileImageView?.image = nil
		}
		
		if let created = tweet?.created {
			let formatter = DateFormatter()
			if Date().timeIntervalSince(created) > 24*60*60 {
				formatter.dateStyle = .short
			} else {
				formatter.timeStyle = .short
			}
			tweetCreatedLabel?.text = formatter.string(from: created)
		} else {
			tweetCreatedLabel?.text = nil
		}
		
	}
}
