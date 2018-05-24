//
//  NumPadType.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public extension NumPad {

    public enum KeyboardType: Int {
        case number = 0
        case decimal = 1
        case phone = 2
    }
    
    public enum InputViewType: Int {
        case textField = 0
        case textView = 1
    }
    
}
