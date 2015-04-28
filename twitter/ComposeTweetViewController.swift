//
//  ComposeTweetViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 4/27/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileComposeImageView: UIImageView!
    
    @IBOutlet weak var nameComposeLabel: UILabel!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetComposeTextView: UITextView!
    
    var isCompose:Bool!
    var screenname: String?
    var tweetContent = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetComposeTextView.delegate = self
        var nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.whiteColor()
        nav?.barTintColor = UIColor(red: 85/255.0, green: 172/255.0, blue: 238/255.0, alpha: 1.0)
        nameComposeLabel.text =  User.currentUser?.name
        var url = User.currentUser?.profileImageUrl
        var screenNameTemp = "@"
        screenNameTemp += User.currentUser!.screenname!
        screenNameLabel.text = screenNameTemp
        
        profileComposeImageView.setImageWithURL(NSURL(string: url!)!)
        println("is compose is: \(isCompose)")
        if((isCompose) == nil){
            tweetComposeTextView.text = "Whats Happening?"
            tweetComposeTextView.textColor = UIColor.grayColor()
        }
        else{
            println("screen name is \(screenname)")
            var textTemp = "@"
            textTemp += screenname!
            tweetComposeTextView.text = textTemp
            tweetContent = textTemp
        }
            // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        tweetComposeTextView.textColor = UIColor.blackColor()

        if(isCompose == nil){
            textView.text = ""
        }

    }
    
    func textViewDidChange(textView: UITextView) {
        tweetContent = textView.text
    }
    
    
    @IBAction func cancelClicked(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func composeTweet(sender: AnyObject) {
        var params:NSMutableDictionary = NSMutableDictionary()
        params.setValue(tweetContent, forKey: "status")
        TwitterClient.sharedInstance.createTweet(params, completion: { (status, error) -> () in
            if(error == nil){
                self.dismissViewControllerAnimated(true, completion: nil)
                println("user just tweeted: \(status)")
            }
            else{
                println(error)
            }
        })
        
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }


}
