//
//  HamburgerViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 5/4/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    var tweetsVC: UINavigationController!
    var hamburgerVC: HamburgerViewController!
    
    @IBOutlet weak var userProfileNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = User.currentUser?.profileImageUrl
        userImage.setImageWithURL(NSURL(string: url!)!)
        userProfileNameLabel.text = _currentUser?.name
        var temp = "@"
        
        var newTemp = _currentUser?.screenname
        temp += newTemp!
        userScreenNameLabel.text = temp
        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsVC = storyboard.instantiateViewControllerWithIdentifier("NavBar") as! UINavigationController
        hamburgerVC = storyboard.instantiateViewControllerWithIdentifier("HamburgerViewController") as! HamburgerViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func homeTimeLinePressed(sender: AnyObject) {
        hamburgerVC.willMoveToParentViewController(nil)
        hamburgerVC.view.removeFromSuperview()
        hamburgerVC.removeFromParentViewController()
        
        addChildViewController(tweetsVC)
        // tweetsVC.view.frame = displayView.frame
        tweetsVC.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.superview!.frame.width, height: self.view.superview!.frame.height)
        self.view.addSubview(tweetsVC.view)
        tweetsVC.didMoveToParentViewController(self)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "myProfileSegue"){
            println("i think im going to  my profile")
            var vc = segue.destinationViewController as! ProfileViewController
            
            vc.isMyOwnProfile = true
            vc.tweet = nil
        }

        
    }
    

}
