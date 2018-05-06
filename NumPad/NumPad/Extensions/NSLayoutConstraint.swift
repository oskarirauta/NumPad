//
//  NSLayoutConstraint.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension NSLayoutConstraint {
    
    func withPriority(_ priority: Int) -> NSLayoutConstraint {
        let layoutConstraint: NSLayoutConstraint = self
        layoutConstraint.priority = UILayoutPriority(rawValue: Float(priority))
        return layoutConstraint
    }
    
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        let layoutConstraint: NSLayoutConstraint = self
        layoutConstraint.priority = UILayoutPriority(rawValue: priority)
        return layoutConstraint
    }
}
