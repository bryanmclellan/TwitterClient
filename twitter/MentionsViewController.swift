//
//  MentionsViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 5/5/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance.getMentionsTimeLine(nil, completion: { (tweets, error) -> () in
            if (error == nil){
                self.tweets = tweets
                self.tableView.reloadData()
            }
            else{
                println(error)
            }
        })
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func backPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
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
