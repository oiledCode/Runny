//
//  RNRingView.swift
//  Runny
//
//  Created by letterio d'antoni on 11/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit
@IBDesignable
public class RNRingView: UIView {
    /*@IBInspectable*/ var progress: Double = 0.0
    @IBInspectable var timeRingInnerColor: UIColor = UIColor.blackColor()
    @IBInspectable var timeRingOuterColor: UIColor = UIColor.greenColor()
    @IBInspectable var distanceRingInnerColor: UIColor = UIColor.blackColor()
    @IBInspectable var distanceRingOuterColor: UIColor = UIColor.greenColor()
    @IBInspectable var radius: CGFloat = 30.0
    @IBInspectable var strokeWidth:CGFloat = 6
    
    let PI_2:Double = 2*M_PI
    let BIG_RADIUS:CGFloat = 30.0
    let SMALL_RADIUS:CGFloat = 40.0
    
    var text:UILabel!
    var time:Int = 10
    var adder:Double = 0.0
    var elapsed:Int = 0
    var timer:NSTimer!
    
    
    override public init(frame: CGRect) {
        super.init(frame:frame);
        self.backgroundColor = UIColor.clearColor()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.text = self.viewWithTag(100) as? UILabel
//        self.text.text? = self.formattedTime(self.time)
        self.adder = PI_2 / Double(self.time)
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect);
        
        let ctx: CGContextRef? = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(ctx,self.strokeWidth)
        CGContextSetLineCap(ctx, CGLineCap.Butt);
        CGContextSetFillColorWithColor(ctx, UIColor.clearColor().CGColor)
        
        // Time Inner ring
        self.timeRingInnerColor.setStroke()
        CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, self.radius, 0, CGFloat(2*M_PI), 0)
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke);
        
        // Time Outer ring
        self.timeRingOuterColor.setStroke()
        CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, self.radius+1, 0, CGFloat(self.progress), 0)
        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke);
        
//        CGContextSetLineWidth(ctx, 6)
        
//        // Distance Inner ring
//        self.distanceRingInnerColor.setStroke()
//        CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, SMALL_RADIUS, 0, CGFloat(2*M_PI), 0)
//        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke);
//        
//        // Distance Outer ring
//        self.distanceRingOuterColor.setStroke()
//        CGContextAddArc(ctx, frame.size.width/2, frame.size.height/2, SMALL_RADIUS, 0, CGFloat(self.progress), 0)
//        CGContextDrawPath(ctx, CGPathDrawingMode.Stroke);
        
    }
    
    func formattedTime(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        
        let minutesString = (minutes > 9) ? "\(minutes)" : "0\(minutes)"
        let secondsString = (seconds > 9) ? "\(seconds)" : "0\(seconds)"
        
        return "\(minutesString):\(secondsString)"
    }
    
    func updateRingView(){
        self.elapsed += 1;
        if(self.elapsed > self.time) {
            self.timer.invalidate()
            return
        }
        self.progress += self.adder;
        self.text.text? = self.formattedTime(self.time - self.elapsed)
        self.setNeedsDisplay();
    }
    
    public func startRingView() {
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: NSSelectorFromString("updateRingView"), userInfo: nil, repeats: true);
        self.timer.fire()
    }
}
