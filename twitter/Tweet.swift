//
//  Tweet.swift
//  twitter
//
//  Created by Bryan McLellan on 4/27/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var tweetId: Int?
    var retweetColor:UIColor?
    var favoriteColor:UIColor
    var numOfRetweets:Int?
    var numOfFavorites:Int?
    var username: String?
   
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        tweetId = dictionary["id"] as? Int
        retweetColor = UIColor.blackColor()
        favoriteColor = UIColor.blackColor()
        numOfFavorites = dictionary["favorite_count"] as? Int
        numOfRetweets = dictionary["retweet_count"] as? Int
        username = dictionary["screen_name"] as? String
        
    }
    
    class func tweetsWithArray ( array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        return tweets
    }


}
