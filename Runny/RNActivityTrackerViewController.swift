//
//  RNActivityTrackerViewController.swift
//  Runny
//
//  Created by letterio d'antoni on 11/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit
import MapKit

class RNActivityTrackerViewController: UIViewController {

    @IBOutlet weak var ringView: RNRingView!
    @IBOutlet weak var map: MKMapView!
    
    var activityType:RNPageViewController.RNPageType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func stopActivityTapped(sender: AnyObject) {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func pauseActivityTapped(sender: AnyObject) {
    }
}
