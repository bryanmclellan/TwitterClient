//
//  ProfileViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 5/4/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var UserNameLabel: UILabel!
    var tweet: Tweet?
    var tweets: [Tweet]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerImageView: UIImageView!
    var bannerURL: String!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var isMyOwnProfile: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        println("is my own profile is \(isMyOwnProfile)")
        if(!isMyOwnProfile){
            UserNameLabel.text = tweet!.user?.name
            var url = tweet?.user?.profileImageUrl
            tweet?.user
            profileImageView.setImageWithURL(NSURL(string: url!)!)
            var params: NSMutableDictionary = NSMutableDictionary()
            params.setValue(tweet?.user?.screenname, forKey: "screen_name")
        }
        else{
            UserNameLabel.text = _currentUser?.name
            var url = _currentUser?.profileImageUrl
            profileImageView.setImageWithURL(NSURL(string: url!)!)
            var params: NSMutableDictionary = NSMutableDictionary()
            params.setValue(_currentUser?.screenname, forKey: "screen_name")
            
        }
        
        var params: NSMutableDictionary = NSMutableDictionary()
        params.setValue(tweet?.user?.screenname, forKey: "screen_name")
        TwitterClient.sharedInstance.getUserTweets(params, completion: { (tweets, error) -> () in
            if (error == nil){
                self.tweets = tweets
                self.tableView.reloadData()
                println("hopefully i just got the user's tweets")
                println("\(tweets?[0].user?.name)")
                println("\(tweets?[0].text)")
                println("\(tweets?[1].user?.name)")
                println("\(tweets?[1].text)")
                println("\(tweets?[2].user?.name)")
                println("\(tweets?[2].text)")

            }
            else{
                println(error)
            }
        })
        
        var params1: NSMutableDictionary = NSMutableDictionary()
        params1.setValue(tweet?.user?.screenname, forKey: "screen_name")
        TwitterClient.sharedInstance.getUserBannerPhoto(params1, completion: { (url, error) -> () in
            if(error==nil){
                self.bannerURL = url!
                self.bannerImageView.setImageWithURL(NSURL(string: self.bannerURL))
                
            }
            else{
                println(error)
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        var tempTweet = tweets?[indexPath.row]
        
        if let newTweet = tempTweet {

            cell.tweetContentLabel.text! = newTweet.text!
            
            cell.tweetContentLabel.sizeToFit()
            
            
            var nameTemp = newTweet.user?.name
            var screename = newTweet.user?.screenname
            var imageURL = newTweet.user?.profileImageUrl
            cell.thumbnailView.setImageWithURL(NSURL(string: imageURL!)!)
            cell.profileNameLabel.text = nameTemp
            cell.profileNameLabel.sizeToFit()
            var time = newTweet.createdAt?.timeIntervalSinceNow
            var timeInt = Int(time! * -1 / 60)
            cell.tweet = newTweet
            //cell.retweetButton.backgroundColor = newTweet.retweetColor
            //cell.favoriteButton.backgroundColor = newTweet.favoriteColor
            cell.timeLabel.text = "\(timeInt) min."
            //tweetAtScreename = newTweet.user?.name
            var temp = "@"
            temp += newTweet.user!.screenname!
            cell.userScreenNameLabel.text = temp
            
            if(timeInt == 0){
                cell.timeLabel.text = "now"
            }

        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
