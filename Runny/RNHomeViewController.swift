//
//  TestViewController.swift
//  Runny
//
//  Created by letterio d'antoni on 20/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNHomeViewController: UIViewController {

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
 
}
