//
//  SmashTweetTableViewController.swift
//  Smashtag
//
//  Created by LinuxPlus on 1/13/18.
//  Copyright © 2018 MarinaS. All rights reserved.
//

import UIKit
import Twitter
import CoreData

class SmashTweetTableViewController: TweetTableViewController
{
//	var container: NSPersistentContainer? =
//		(UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
//
//	override func insertTweets(_ newTweets: [Twitter.Tweet]) {
//		super.insertTweets(newTweets)
//		updateDatabase(with: newTweets)
//	}
//	
//	private func updateDatabase(with tweets: [Twitter.Tweet]) {
//		container?.performBackgroundTask {context in
//			for twitterInfo in tweets {
//				// add Tweet
//				_ = try? Tweet.findOrCreateTweet(matching: twitterInfo, in: context)
//			}
//		}
//		printDatabaseStatistics()
//	}
//	private func printDatabaseStatistics() {
//		if let context = container?.viewContext {
//			let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
//			if let tweetCount = (try? context.fetch(request))?.count {
//				print("\(tweetCount) tweets")
//			}
//			if let tweeterCount = try? context.count(for: TwitterUser.fetchRequest()) {
//				print("\(tweeterCount) Twitter users")
//			}
//			if let tweeterCount = try? context.count (for: TwitterUser.fetchRequest()) {
//				print("\(tweeterCount) Twitter users")
//			}
//		}
//	}

}
