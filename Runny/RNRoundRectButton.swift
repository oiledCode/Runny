//
//  RNRoundRectButton.swift
//  Runny
//
//  Created by letterio d'antoni on 11/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

@IBDesignable
public class RNRoundRectButton: UIButton {
    @IBInspectable var cornerRadius:CGFloat = 0.0
    @IBInspectable var fillColor:UIColor = UIColor.blackColor()
    
    override public init(frame: CGRect) {
        super.init(frame:frame);
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner.AllCorners, cornerRadii: CGSize(width: self.cornerRadius, height: self.cornerRadius))
        fillColor.setFill()
        path.fill()
        
    }

}
