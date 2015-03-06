//
//  ParseViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/19/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class ParseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var parseView: UIView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submit.addTarget(self, action: "submitData", forControlEvents: UIControlEvents.TouchDown)
        photoButton.addTarget(self, action: "selectPhoto", forControlEvents: UIControlEvents.TouchDown)
        cameraButton.addTarget(self, action: "useCamera", forControlEvents: UIControlEvents.TouchDown)
        cameraButton.hidden = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.hidden = false
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    dynamic func submitData()
    {
        var gameScore = PFObject(className: "Score")
        gameScore["player"] = text?.text
        gameScore["score"] = 700
        gameScore.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Success")
            }
            else {
                println("Failure")
            }
        }
        //var objectID = gameScore.objectId
        var objectID = "jnvveI5jYg"
        var query = PFQuery(className: "Score")
        query.getObjectInBackgroundWithId(objectID) {(score: PFObject!, error: NSError!) -> Void in
            if (error == nil) {
                println("Successful Load")
                println(score["player"])
                println(score["score"])
            }
            else {
                println("Failure Load")
            }
        }
    }
    
    dynamic func useCamera()
    {
        var cameraView = CameraViewController()
        cameraView.delegate = self
        presentViewController(cameraView, animated: true, completion: nil)
    }
    
    dynamic func selectPhoto()
    {
        var cameraView = CameraViewController()
        cameraView.delegate = self
        presentViewController(cameraView, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
            dismissViewControllerAnimated(false, completion: {() -> Void in
            //self.presentViewController(DetailViewController(), animated: true, completion: nil)
            self.performSegueWithIdentifier("detailImage", sender: image)
        })
        
        
        
        /*
        var imageID = "eMZp7IaPgL"
        var query = PFQuery(className: "Photo")
        query.getObjectInBackgroundWithId(imageID) {(photo: PFObject!, error: NSError!) -> Void in
            if (error == nil) {
                println("Successful Load")
                var imageView = UIImageView(image: UIImage(data: photo["photo"].getData()))
                self.view.addSubview(imageView)
            }
            else {
                println("Failure Loading Image Class")
            }
        }
*/
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailImage" {
            let detail = segue.destinationViewController as DetailViewController
            detail.labelText = "hello"
            detail.imageObj = sender as UIImage
        }
    }
}
