//
//  DetailViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/18/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tagsTextBox: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    
    var userID : String! = ""
    
    var imageObj : UIImage = UIImage()
        {
        didSet {
            image?.image = imageObj
        }
    }
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
    }
    
    @IBAction func submitPhoto(sender: AnyObject) {

        var photoData = UIImagePNGRepresentation(imageObj)
        var photoFile = PFFile(name: "photo.png", data: photoData)
        photoFile.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            var tags = self.tagsTextBox.text.componentsSeparatedByString(" ")
            var photoObject = PFObject(className: "Outfit")
            photoObject["userID"] = self.userID
            photoObject["photo"] = photoFile
            photoObject["tags"] = tags
            photoObject["score"] = 0
            photoObject.saveInBackgroundWithBlock(nil)
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        image?.image = imageObj
        tagsTextBox.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

