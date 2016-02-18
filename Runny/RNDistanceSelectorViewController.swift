//
//  ViewController1.swift
//  Runny
//
//  Created by letterio d'antoni on 20/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNDistanceSelectorViewController: UIViewController, RNActivityStepperViewDelegate {

    @IBOutlet weak var distanceStepper: RNActivityStepperView!
    
    var selectedDistance: Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.distanceStepper.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func stepperViewValueDidChange(value: AnyObject?) {
        print("stepperValueDidChange")
        if let value = value as? NSNumber {
            self.selectedDistance = value.floatValue
        }
    }
    
}
