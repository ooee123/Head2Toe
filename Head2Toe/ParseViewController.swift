//
//  ParseViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/19/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class ParseViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UISearchBarDelegate {

    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var userID : String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.hidden = false
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            cameraButton.hidden = true
        }
        searchBar.delegate = self
        // Do any additional setup after loading the view.
        self.userID = (tabBarController as HomePageTabBarController).user!.objectID
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func useCamera(sender: AnyObject) {
        var cameraView = CameraViewController()
        cameraView.delegate = self
        presentViewController(cameraView, animated: true, completion: nil)
    }
    
    @IBAction func selectPhoto(sender: AnyObject) {
        var cameraView = CameraViewController()
        cameraView.delegate = self
        presentViewController(cameraView, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
            dismissViewControllerAnimated(false, completion: {() -> Void in
            self.performSegueWithIdentifier("detailImage", sender: image)
        })
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var tokens = searchBar.text.componentsSeparatedByString(" ")
        tokens = tokens.map({ (s: String) -> String in
            return s.lowercaseString
        })
        let q = PFQuery(className: "Outfit")
        q.whereKey("tags", containsAllObjectsInArray: tokens)
        q.findObjectsInBackgroundWithBlock { (results: [AnyObject]!, error: NSError!) -> Void in
            var outfitObjs : [AnyObject] = []
            for r in results {
                outfitObjs.append(r.objectId)
            }
            let qu = PFQuery(className: "Outfit")
            qu.whereKey("objectId", containedIn: outfitObjs)
            qu.findObjectsInBackgroundWithBlock({ (results: [AnyObject]!, error: NSError!) -> Void in
                    let res = results as [PFObject]
                    self.performSegueWithIdentifier("SearchResults", sender: res)
            })
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailImage" && sender is UIImage {
            let detail = segue.destinationViewController as DetailViewController
            detail.userID = userID
            detail.imageObj = sender as UIImage
        }
        if segue.identifier == "SearchResults" {
            let outfits = sender as [PFObject]
            let dest = segue.destinationViewController as OutfitsCollectionViewController
            dest.outfits = outfits
        }
    }
}
