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
                let score = object["score"].intValue
                thumbsUpCounter?.text = "\(score)"
                let tags = JSON(object["tags"])
                let str = tags.arrayObject as [String]
                tagsLabel?.text = "\(str)"
            }
        }
    }
    
    @IBOutlet weak var tagsLabel: UILabel! {
        didSet {
            if let object = object? {
                let tags = JSON(object["tags"])
                let str = tags.arrayObject as [String]
                tagsLabel.text = "\(str)"
            }
        }
    }
    
    @IBOutlet weak var thumbsUpCounter: UILabel! {
        didSet {
            if let object = object? {
                let score = object["score"].intValue
                thumbsUpCounter.text = "\(score)"
            }
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
            var score = object["score"].integerValue
            object["score"] = score + 1
            object.saveInBackgroundWithBlock(nil)
            self.object = object
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
