//
//  TwitterClient.swift
//  twitter
//
//  Created by Bryan McLellan on 4/26/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

let twitterConsumerKey = "DdvFwwN0D4P3qx1s4Fq3Z0A8n"
let twitterConsumerSecret = "zqPl0dFvpq5PZietJYmjwDfi8A0IJ5CYJhMDYQ5e4HAAmuMlaO"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
   
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimeLineWithParams (params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
       GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            completion(tweets: tweets, error: nil)
            //println("\(response)")
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("couldnt get the timeline")
                completion(tweets: nil, error: error)

        })
        
        }
    
//    func createTweet (params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
//        POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
//            var tweet = Tweet(dictionary: response as! NSDictionary)
//            completion(tweet: tweet, error: nil)
//            println("\(response)")
//            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
//                println("failed to post the tweet")
//                completion(tweet: nil, error: error)
//                
//        })
//        
//    }
    
    func createTweet(params: NSDictionary?, completion: (status: Tweet?, error: NSError?) -> ()) {
        self.POST("1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as! NSDictionary)
            completion(status: tweet, error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error posting status update")
                completion(status: nil, error: error)
        }
    }
    
    func favorite (params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        self.POST("1.1/favorites/create.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as! NSDictionary)
            println("the id i got to favorite is \(tweet.tweetId)")
            completion(id: tweet.tweetId!, error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error favoriting")
                completion(id: nil, error: error)
        }
    }
    
    func retweet (id: Int?, completion: (id: Int?, error: NSError?) -> ()) {
        self.POST("1.1/statuses/retweet/\(id!).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            var tweet = Tweet(dictionary: response as! NSDictionary)
            var tweetId = tweet.tweetId
            println("the id i got to retweet is \(id)")
            completion(id: tweetId!, error: nil)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error retweeting")
                completion(id: nil, error: error)
                
        }
    }

    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
        loginCompletion = completion
        
        
        //fetch request token & redirect to auth page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("got the token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(authURL)
            }) { (error:NSError!) -> Void in
                println("failed to get the request token \(error)")
                self.loginCompletion?(user:nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential (queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println("user: \(response)")
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                println("user: \(user.name)")
                self.loginCompletion?(user:user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting user")
                    self.loginCompletion?(user:nil, error: error)
            })
            
          
            }) { (error: NSError!) -> Void in
                println("failed to recieve the access token")
                self.loginCompletion?(user:nil, error: error)

        }

    }
    
    
    
}
