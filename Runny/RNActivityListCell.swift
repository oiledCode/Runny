//
//  RNActivityListCell.swift
//  Runny
//
//  Created by letterio d'antoni on 11/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

class RNActivityListCell: UITableViewCell {

    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var stepRingView: RNRingView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    var expanded:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func configureForActivity(activity:NSDictionary) {
        self.distanceLabel.text = activity["distance"]! as? String
        self.timeLabel.text = activity["time"]! as? String
        self.paceLabel.text = activity["pace"]! as? String
        self.caloriesLabel.text = activity["calories"]! as? String
        if let x = (activity["steps"] as? NSNumber) {
        self.stepRingView.text.text = x.stringValue.stringByAppendingString("%")
        let d:Double = (x.doubleValue * (2*M_PI)) / 100
        self.stepRingView.progress = d
        }
    }
}
