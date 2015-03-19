//
//  OutfitDetailViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 3/17/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class OutfitDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    @IBOutlet var commentText: UITextView!
    
    
    var object : PFObject? = nil {
        didSet {
            if let object = object? {
                uiImage?.image = UIImage(data: object["photo"].getData())
                updateThumbsUpCount()
                updateTags()
                commentsTableView?.reloadData()
            }
        }
    }
    
    @IBAction func commentButton(sender: UIButton) {
        if let object2 = object? {
            var comments = JSON(object2["comments"]).arrayObject as [String]
            comments.append(commentText.text)
            object2["comments"] = comments
            object2.saveInBackgroundWithBlock(nil)
            object = object2
        }
        if commentText.isFirstResponder() {
            commentText.resignFirstResponder()
        }
        commentText.text = ""
    }
    
    @IBOutlet var commentsTableView: UITableView!
    
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
        commentText.delegate = self
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object!["comments"].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentsID") as UITableViewCell
        if let unwrapped = object? {
            let comments = JSON(unwrapped["comments"]).arrayObject as [String]
            cell.textLabel?.text = comments[indexPath.row]
        }
        return cell
    }
    
    func updateComments() {
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = event.allTouches()?.anyObject() as UITouch
        if (commentText.isFirstResponder() && touch.view != commentText) {
            commentText.resignFirstResponder()
        }
        super.touchesBegan(touches, withEvent: event)
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
