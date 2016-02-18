//
//  RNMeasureMangere.swift
//  Runny
//
//  Created by letterio d'antoni on 20/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import Foundation
import CoreLocation
import CoreMotion

protocol RNMeasureManagerDelegate {
    func distanceDidChange(distance:Double)
    func stepsCountDidChange(steps: Int)
}

public class RNMeasureManger:NSObject, CLLocationManagerDelegate {
    
    var distance:Double = 0
    var locationManager: CLLocationManager!
    var pedometer: CMPedometer!
    var delegate:RNMeasureManagerDelegate?
    
    public override init() {
        super.init()
        self.setupLocationManager()
    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    public func startTrackingLocation() {
        self.locationManager.delegate = self;
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation();
    }
    
    
    public func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let newDistance = round(newLocation.distanceFromLocation(oldLocation) / 1000)
        if(self.distance != newDistance && newDistance >= 0.1) {
            self.distance = newDistance
            self.delegate?.distanceDidChange(self.distance)
        }
    }
    
    
    public func initPedometer() {
        if(CMPedometer.isStepCountingAvailable()) {
            let date = NSDate()
            pedometer.startPedometerUpdatesFromDate(date, withHandler: { (data, error) -> Void in
                if let error = error {
                    print("\(error)")
                } else {
                    if let data = data {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.delegate?.stepsCountDidChange(data.numberOfSteps.integerValue)
                        })
                    }
                }
            })
        }
    }
}

