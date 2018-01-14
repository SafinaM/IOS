//
//  TwitterUser.swift
//  Smashtag
//
//  Created by MarinaS on 14/01/2018.
//  Copyright © 2017 MarinaS. All rights reserved.
//

import UIKit
import CoreData
import Twitter

class TwitterUser: NSManagedObject
{
    class func findOrCreateTwitterUser(matching twitterInfo: Twitter.User, in context: NSManagedObjectContext) throws -> TwitterUser
    {
        let request: NSFetchRequest<TwitterUser> = TwitterUser.fetchRequest()
        request.predicate = NSPredicate(format: "handle = %@", twitterInfo.screenName)
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
				// assert 'sanity': if condition false ... then print message and interrupt program
                assert(matches.count == 1, "TwitterUser.findOrCreateTwitterUser -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        // no match, instantiate TwitterUser
        let twitterUser = TwitterUser(context: context)
        twitterUser.handle = twitterInfo.screenName
        twitterUser.name = twitterInfo.name
        return twitterUser
    }


}
