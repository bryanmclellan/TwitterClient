//
//  TweetsViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 4/27/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    var tweets: [Tweet]?
    var tweetAtScreename: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
       
        var nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.barTintColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1.0)

        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets, error) -> () in
            if (error == nil){
            self.tweets = tweets
            self.tableView.reloadData()
            }
            else{
                println(error)
            }
        })
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func onRefresh(){
        TwitterClient.sharedInstance.homeTimeLineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        })
        self.refreshControl.endRefreshing()
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        println("\(indexPath.row)")
        var tempTweet = tweets?[indexPath.row]
        if let newTweet = tempTweet{
            cell.tweetContentLabel.text = newTweet.text
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
            tweetAtScreename = newTweet.user?.name
            var temp = "@"
            temp += newTweet.user!.screenname!
            cell.userScreenNameLabel.text = temp

            if(timeInt == 0){
                cell.timeLabel.text = "now"
            }
        }
        //tableView.rowHeight = UITableViewAutomaticDimension
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        var tempTweet = tweets?[indexPath.row]
//        tweetAtScreename = newTweet.user?.screenname!
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(sender: AnyObject) {
        println("clicked logout")
        User.currentUser?.logout()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        println("now im really navigating with \(tweetAtScreename)")
        if (segue.identifier == "composeTweet"){
            var vc = segue.destinationViewController as! ComposeTweetViewController
            println("composing a tweet")
            vc.isCompose = true
        }
        else{
            if(segue.identifier == "replySegue"){
            println("i think im responding to a tweet")
            var vc = segue.destinationViewController as! ComposeTweetViewController
            
            var tempCell1 = sender as! UIButton
            var tempCell = tempCell1.superview?.superview as! TweetCell
            vc.isCompose = false
            vc.screenname = tempCell.tweet?.user?.screenname
            }
            else{
                if(segue.identifier == "detailsSegue"){
                    println("i think im going to a tweet")
                    var vc = segue.destinationViewController as! TwitterDetailsViewController
                    var tempCell = sender as! TweetCell
                    vc.tweet = tempCell.tweet
                }
                else if(segue.identifier == "profileSegue"){
                    println("i think im going to a user's profile")
                    var vc = segue.destinationViewController as! ProfileViewController
                    
                    var tempCell1 = sender as! UIButton
                    var tempCell = tempCell1.superview?.superview as! TweetCell
                    vc.isMyOwnProfile = false
                    vc.tweet = tempCell.tweet
            }
            
        }
        
    }
    
    }


}
