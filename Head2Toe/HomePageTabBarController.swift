//
//  HomePageTabBarController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/7/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class HomePageTabBarController: UITabBarController, UITabBarControllerDelegate {

    var user : FBGraphUser? = nil
    var userObj : PFObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let viewController = viewController as? UINavigationController {
            if let v = viewController.viewControllers.first as? OutfitsCollectionViewController {
                // Display news feed
                // Get all my friends or my own images
                let r = FBRequest.requestForMyFriends()
                var allIDs : [String] = []
                r.startWithCompletionHandler { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
                    let friends = JSON((result as NSDictionary)["data"]!)
                    for (index, friend) in friends {
                        let id = friend["id"].stringValue
                        allIDs.append(id)
                    }
                }
                allIDs.append(user!.objectID)
                
                var query = PFQuery(className: "Outfit")
                query.whereKey("userID", containedIn: allIDs)
                query.addAscendingOrder("createdAt")
                query.findObjectsInBackgroundWithBlock({ (results: [AnyObject]!, error: NSError!) -> Void in
                    v.outfits = results as [PFObject]
                })
            }
            else if let v = viewController.viewControllers.first as? ProfileViewController {
                // We're looking at my own profile
                v.userObject = userObj
            }
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
