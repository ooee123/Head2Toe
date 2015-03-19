//
//  LoginViewController.swift
//  Head2Toe
//
//  Created by Melissa Wang on 2/22/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBLoginViewDelegate {
    
    @IBOutlet var fbLoginView : FBLoginView!
    
    var user : FBGraphUser? = nil
    var userObj : PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginView.center = self.view.center;
        view.addSubview(fbLoginView)
        
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "HomeSegue" {
            let homePage = segue.destinationViewController as HomePageTabBarController
            homePage.user = user
            homePage.userObj = userObj
        }
    }

    // Facebook Delegate Methods
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        
        
        
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        //println("User: \(user)")
        //println("User ID: \(user.objectID)")
        //println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        //println("User Email: \(userEmail)")
        
        self.user = user
        
        let q = PFQuery(className: "User")
        q.whereKey("facebookID", equalTo: user.objectID)
        let results = q.findObjects()
        if results.count == 0 {
            let obj = PFObject(className: "User")
            obj["facebookID"] = user.objectID
            obj["firstName"] = user.first_name
            obj["lastName"] = user.last_name
            obj.saveInBackgroundWithBlock(nil)
            self.userObj = obj
        }
        else
        {
            self.userObj = results.first as? PFObject
        }
        performSegueWithIdentifier("HomeSegue", sender: self)
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }
}