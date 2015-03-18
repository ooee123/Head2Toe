//
//  OutfitDetailViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/17/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class OutfitDetailViewController: UIViewController {
    
    var object : PFObject? = nil {
        didSet {
            if let object = object? {
                uiImage?.image = UIImage(data: object["photo"].getData())
                updateThumbsUpCount()
                updateTags()
            }
        }
    }
    
    @IBOutlet weak var tagsLabel: UILabel! {
        didSet {
            updateTags()
        }
    }
    
    @IBOutlet weak var thumbsUpCounter: UILabel! {
        didSet {
            updateThumbsUpCount()
        }
    }
    @IBOutlet weak var uiImage: UIImageView! {
        didSet {
            if let object = object? {
                uiImage.image = UIImage(data: object["photo"].getData())
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func thumbsUpClicked(sender: AnyObject) {
        if let object = object? {
            var likedIDs = JSON(object["likedIDs"]).arrayObject as [String]
            let userID = (tabBarController as HomePageTabBarController).user?.objectID
            if !contains(likedIDs, userID!) {
                likedIDs.append(userID!)
                object["likedIDs"] = likedIDs
                updateThumbsUpCount()
                object.saveInBackgroundWithBlock(nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateThumbsUpCount() {
        if let object = object? {
            var likedIDs = JSON(object["likedIDs"]).arrayObject as [String]
            thumbsUpCounter?.text = "\(likedIDs.count)"
        }
    }
    
    func updateTags() {
        if let object = object? {
            let tags = JSON(object["tags"])
            let str = tags.arrayObject as [String]
            tagsLabel?.text = "\(str)"
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
