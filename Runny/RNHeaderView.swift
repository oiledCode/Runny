//
//  RNHeaderView.swift
//  Runny
//
//  Created by letterio d'antoni on 10/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNHeaderView: UIView {
    
    let deltaFactor:CGFloat = 0.5
    
    var scrollView:UIScrollView!
    var subView:UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, subview:UIView) {
        self.init(frame: frame)
        self.scrollView = UIScrollView.init(frame: self.bounds)
        self.subView = subview;
        self.scrollView.addSubview(subView)
        self.addSubview(self.scrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func relayoutWithOffSet(offset:CGPoint) {
        var frame = self.scrollView.frame
        
        if(offset.y > 0) {
            frame.origin.y = max(offset.y * self.deltaFactor , 0)
            print("origin : ",frame.origin.y)
            self.scrollView.frame = frame
            self.clipsToBounds = true
        } else {
            var delta = 0.0
            var rect  = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            
            delta = fabs(min(0.0, Double(offset.y)))
            
            rect.origin.y -= CGFloat(delta)
            
            print("origin : ",frame.origin.y)

            rect.size.height += CGFloat(delta)
            self.clipsToBounds = false;
            self.scrollView.frame = rect
        }
    }
    
}
