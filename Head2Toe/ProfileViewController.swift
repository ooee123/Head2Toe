//
//  ProfileViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/18/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            if let userObject = userObject? {
                let first = userObject["firstName"] as String
                let last = userObject["lastName"] as String
                nameLabel?.text = "\(first) \(last)"
            }
        }
    }
    
    var userObject : PFObject? = nil {
        didSet {
            if let userObject = userObject? {
                let first = userObject["firstName"] as String
                let last = userObject["lastName"] as String
                nameLabel?.text = "\(first) \(last)"
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userOutfitsClicked(sender: AnyObject) {
        let q = PFQuery(className: "Outfit")
        q.whereKey("userID", equalTo: userObject?["facebookID"])
        q.addAscendingOrder("createdAt")
        q.findObjectsInBackgroundWithBlock { (results: [AnyObject]!, error: NSError!) -> Void in
            self.performSegueWithIdentifier("OutfitCollectionSegue", sender: results)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "OutfitCollectionSegue" {
            let outfits = sender as [PFObject]
            let dest = segue.destinationViewController as OutfitsCollectionViewController
            dest.outfits = outfits
        }
        if segue.identifier == "FriendsListSegue" {
            let dest = segue.destinationViewController as FriendsListTableViewController
            
        }
    }


}