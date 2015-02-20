//
//  ParseViewController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/19/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit

class ParseViewController: UIViewController {

    @IBOutlet var parseView: UIView!
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submit.addTarget(self, action: "submitData", forControlEvents: UIControlEvents.TouchDown)
    
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    dynamic func submitData()
    {
        var gameScore = PFObject(className: "Score")
        gameScore["player"] = "Ooee"
        gameScore["score"] = 700
        gameScore.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (success) {
                println("Success")
            }
            else {
                println("Failure")
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
