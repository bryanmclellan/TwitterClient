//
//  TwitterDetailsViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 4/27/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class TwitterDetailsViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var url = tweet!.user?.profileImageUrl
        profileImage.setImageWithURL(NSURL(string: url!)!)
        timeLabel.text = tweet!.createdAt?.description
        tweetContentLabel.text = tweet!.text
        println("i am \(tweet!.user?.name!)")
        userNameLabel.text = tweet!.user?.name!
       
        var screenNameTemp = "@"
        screenNameTemp += tweet!.user!.screenname!
        userScreenNameLabel.text = screenNameTemp
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backButtonClicked(sender: AnyObject) {
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
