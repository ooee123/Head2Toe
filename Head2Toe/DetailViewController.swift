//
//  DetailViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/18/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    var labelText : String = "Hello"
        {
        didSet {
            descriptionLabel?.text = labelText
        }
    }
    
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
        /*
        if let detail: AnyObject = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
*/
    }
    @IBAction func submitPhoto(sender: AnyObject) {

        var photoData = UIImagePNGRepresentation(image.image)
        var photoFile = PFFile(name: "photo.png", data: photoData)
        photoFile.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Successful Photo Save")
            }
            else {
                println("Failure Photo Save")
            }
        }
        
        var photoObject = PFObject(className: "Outfit")
        photoObject["name"] = "Ooee"
        photoObject["photo"] = photoFile
        photoObject.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Success")
            }
            else {
                println("Failure")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)

        //dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        descriptionLabel?.text = labelText
        image?.image = imageObj
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

