//
//  TweetCell.swift
//  twitter
//
//  Created by Bryan McLellan on 4/27/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favoriteClicked(sender: AnyObject) {
        var params:NSMutableDictionary = NSMutableDictionary()
        params.setValue(tweet?.tweetId, forKey: "id")
        TwitterClient.sharedInstance.favorite(params, completion: { (id, error) -> () in
            if(error == nil){
              //  self.tweet!.favoriteColor = UIColor.yellowColor()
                var favoriteButton = sender as! UIButton
                favoriteButton.tintColor = UIColor.yellowColor()
                println("just favorited \(self.tweet)")
            }
            else{
                println(error)
            }
        })
    }
    
    @IBAction func replyClicked(sender: AnyObject) {
            
    }
    
    @IBAction func retweetClicked(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet( tweet?.tweetId, completion: { (id, error) -> () in
        if(error == nil){
           // self.tweet!.retweetColor = UIColor.greenColor()
            var favoriteButton = sender as! UIButton
            favoriteButton.tintColor = UIColor.greenColor()
        }
        else{
            println(error)
        }
    })
}

}