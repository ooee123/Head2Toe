//
//  CameraViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/20/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class CameraViewController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
            println("Using Camera as Source")
            sourceType = UIImagePickerControllerSourceType.Camera
        }
        else
        {
            println("Using Photos as Source")
            sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        }
        // Do any additional setup after loading the view.
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
