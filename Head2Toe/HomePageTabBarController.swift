//
//  HomePageTabBarController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/7/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class HomePageTabBarController: UITabBarController, UITabBarControllerDelegate {

    var user : FBGraphUser? = nil {
        didSet {
            println("Setted")
        }
    }

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
        println("Called")
        if let viewController = viewController as? UINavigationController {
            if let v = viewController.viewControllers.first as? OutfitsCollectionViewController {
                println("Casted Correctly")
                var query = PFQuery(className: "Outfit")
                query.whereKey("userID", equalTo: user?.objectID)
            
                query.findObjectsInBackgroundWithBlock({ (results: [AnyObject]!, error: NSError!) -> Void in
                    v.outfits = results as [PFObject]
                })
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
