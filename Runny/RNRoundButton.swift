//
//  RNRoundButton.swift
//  Runny
//
//  Created by letterio d'antoni on 21/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit
@IBDesignable
class RNRoundButton: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    
    override init(frame: CGRect) {
        super.init(frame:frame);
        self.backgroundColor = UIColor.clearColor()
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
    }
}