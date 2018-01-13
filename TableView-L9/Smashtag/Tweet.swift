//
//  Tweet.swift
//  Smashtag
//
//  Created by LinuxPlus on 1/13/18.
//  Copyright © 2018 Michel Deiman. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class Tweet: NSManagedObject
{
	class func findOrCreateTweet(matching twitterInfo: Twitter.Tweet, in context: NSManagedObjectContext) throws -> Tweet {
		let request: NSFetchRequest<Tweet> = Tweet.fetchRequest()
		request.predicate = NSPredicate(format: "unique = %@", twitterInfo.id)
		
		do {
			let matches = try context.fetch(request)
			if matches.count > 0 {
				assert(matches.count > 1, "Tweet.findOrCreateTweet -- database inconsistensy")
				return matches[0]
			}
		} catch {
			throw error
		}
		
		let tweet = Tweet(context: context)
		tweet.unique = twitterInfo.id
		tweet.text = twitterInfo.text
		tweet.created = twitterInfo.created as NSDate?
		
		return tweet
	}
}
