//
//  ShadowView.swift
//  Kashing
//
//  Created by Home on 1/6/16.
//  Copyright © 2016 DanielOng. All rights reserved.
//

import Foundation
import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
    }

}
