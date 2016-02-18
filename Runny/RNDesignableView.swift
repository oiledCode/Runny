//
//  RNDesignableView.swift
//  Runny
//
//  Created by letterio d'antoni on 11/02/16.
//  Copyright © 2016 letterio d'antoni. All rights reserved.
//

import UIKit

@IBDesignable
public class RNDesignableView: UIView {
    override public init(frame: CGRect) {
        super.init(frame:frame);
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);

    }
}
