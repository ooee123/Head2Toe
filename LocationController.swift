//
//  LocationController.swift
//  Head2Toe
//
//  Created by Classroom Tech User on 2/22/15.
//  Copyright (c) 2015 Kevin Ly. All rights reserved.
//

import UIKit
import CoreLocation

class LocationController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!
    @IBOutlet var locationView: UIView!
    @IBOutlet weak var landmark: UILabel!
    @IBOutlet weak var longDescription: UITextView!

    let location : CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("Entered view controller")
        let location = CLLocationManager()
        location.desiredAccuracy = 10
        location.distanceFilter = 1
        location.delegate = self
        
        location.startUpdatingLocation()
        println("Is enabled? \( CLLocationManager.locationServicesEnabled())")
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