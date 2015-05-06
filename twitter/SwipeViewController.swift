//
//  SwipeViewController.swift
//  twitter
//
//  Created by Bryan McLellan on 5/4/15.
//  Copyright (c) 2015 Bryan McLellan. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    var tweetsVC: UINavigationController!
    var hamburgerVC: HamburgerViewController!
    @IBOutlet weak var displayView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsVC = storyboard.instantiateViewControllerWithIdentifier("NavBar") as! UINavigationController
        hamburgerVC = storyboard.instantiateViewControllerWithIdentifier("HamburgerViewController") as! HamburgerViewController
        
        // Do any additional setup after loading the view.
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("wasSwiped:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("wasSwiped:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        
        addChildViewController(tweetsVC)
        tweetsVC.view.frame = CGRect(x: 0.0, y: 0.0, width: displayView.frame.width, height: displayView.frame.height)
        displayView.addSubview(tweetsVC.view)
        tweetsVC.didMoveToParentViewController(self)
        println("i put in the tweetsVC")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func wasSwiped(sender: UISwipeGestureRecognizer) {
        println("some shit was swiped")
        
        if sender.direction == UISwipeGestureRecognizerDirection.Left {
            println("left swipe")
            hamburgerVC.willMoveToParentViewController(nil)
            hamburgerVC.view.removeFromSuperview()
            hamburgerVC.removeFromParentViewController()
           // self.tweetsVC.view.frame.origin = CGPoint(x: 100.0, y: 100.0)
           // self.tweetsVC.view.frame.origin = CGPointMake(self.tweetsVC.view.frame.origin.x + 50, self.tweetsVC.view.frame.origin.y)
            addChildViewController(tweetsVC)
           // tweetsVC.view.frame = displayView.frame
            tweetsVC.view.frame = CGRect(x: 0.0, y: 0.0, width: displayView.frame.width, height: displayView.frame.height)
            displayView.addSubview(tweetsVC.view)
            tweetsVC.didMoveToParentViewController(self)
        }
        
        
        if sender.direction == UISwipeGestureRecognizerDirection.Right{
                println("right swipe")
         //       tweetsVC.willMoveToParentViewController(nil)
         //       tweetsVC.view.removeFromSuperview()
         //       tweetsVC.removeFromParentViewController()
                addChildViewController(hamburgerVC)
                hamburgerVC.view.frame = CGRect(x: 0.0, y: 0.0, width: displayView.frame.width - 60, height: displayView.frame.height)
                displayView.addSubview(hamburgerVC.view)
                hamburgerVC.didMoveToParentViewController(self)
        
            }
        
        
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
