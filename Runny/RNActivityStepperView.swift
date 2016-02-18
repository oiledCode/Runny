//
//  RNSActivityStepperView.swift
//  Runny
//
//  Created by letterio d'antoni on 21/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit



protocol RNActivityStepperViewDelegate {
    func stepperViewValueDidChange(value:AnyObject?)
}

@IBDesignable
class RNActivityStepperView: UIView {
    
    @IBInspectable var distanceStepper:Bool = false
    @IBInspectable var timeStepper:Bool = false
    
    @IBOutlet var plusButton: RNRoundButton!
    @IBOutlet var minusButton: RNRoundButton!
    @IBOutlet var valueLabel: UILabel!
    
    var delegate:RNActivityStepperViewDelegate?
    
    // The dafault increments for the distance is 100 meters
    let defaultDistanceIncrement:Float = 0.1
    
    // The default increment for the time is 30 seconds
    let defaultTimeIncrement:Int = 30
    
    
    // The initalizers are not really needed
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder : coder)!
    }
    
    @IBAction func buttonPressed(sender: RNRoundButton) {
        let stepperValue = self.valueLabel.text!
        var value: NSNumber?
        
        let x = sender.isEqual(self.plusButton) ? 1 : -1
        
        if self.distanceStepper {
            let a = RNConversionUtils.distanceFromString(stepperValue).floatValue
            let b = (defaultDistanceIncrement * Float(x))
            let c = a + b
            print(a)
            print(b)
            print(c)
            value = RNConversionUtils.distanceFromString(stepperValue).floatValue + (defaultDistanceIncrement * Float(x))
            self.valueLabel.text! = RNConversionUtils.stringFromDistance(value!)
        } else {
            value = RNConversionUtils.timeFromString(stepperValue).integerValue + (defaultTimeIncrement * x)
            self.valueLabel.text! = RNConversionUtils.stringFromTime(value!)
        }
        
        self.delegate?.stepperViewValueDidChange(value)
    }
}

