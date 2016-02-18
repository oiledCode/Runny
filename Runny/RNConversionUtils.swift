//
//  File.swift
//  Runny
//
//  Created by letterio d'antoni on 21/01/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import Foundation

class RNConversionUtils: NSObject {
    
    // the string we are receiving as a parameter have the following format:
    // 00.0 -> 99.9 we have to convert this string in kilometers
    class func distanceFromString(distanceString: String) -> NSNumber {
        let distanceNumber = Float(distanceString)
        return distanceNumber!
    }
    
    // the string we are receiving as a aprameter have the following format
    // 00:00 ->
    class func timeFromString(timeString: String) -> NSNumber {
        let components:[String] = timeString.componentsSeparatedByString(":")
        let minutes = Int(components[0])! * 60
        let seconds = Int(components[1])!
        return NSNumber(integer:minutes + seconds)
    }
    
     class func stringFromDistance(distance: NSNumber) -> String {
        let floatValue  = distance.floatValue
        let integerPart = NSInteger(floatValue)
        
        var fractionalPart = roundf((floatValue - Float(integerPart)) * 10)

        fractionalPart = fractionalPart > 9 ? 9 : fractionalPart

        var stringValue = ""
        stringValue += (integerPart > 10 ) ? ("\(integerPart)") : ("0\(integerPart)")
        stringValue += (fractionalPart > 0) ? (".\(Int(fractionalPart))") : ".0"
        return stringValue
    }
    
    class func stringFromTime(time: NSNumber) -> String {
        let integerTime = time.integerValue
        let minutes = integerTime / 60
        let seconds = integerTime % 60
        let secondsString = seconds == 0 ? "00" : "\(seconds)"
        return "\(minutes):\(secondsString)"
    }
    
}
