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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println("Entered view controller")
        let location = CLLocationManager()
        location.desiredAccuracy = 10
        location.distanceFilter = 1
        location.delegate = self
        location.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Inside location delegate")
        let lastLocation = locations.last as CLLocation
        latitude.text = "Latitude: \(lastLocation.coordinate.latitude)"
        longitude.text = "Latitude: \(lastLocation.coordinate.longitude)"
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(lastLocation) {(placemark: [AnyObject]!, error: NSError!) -> Void in
            if (error == nil) {
                let mark = placemark.last as CLPlacemark
                self.landmark.text = mark.name
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