//
//  DoneBar.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class DoneBar: UIToolbar {

    private(set) weak var textView: UITextInput?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init(delegate: UITextInput) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textView = delegate
        self.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
        ]
    }
    
    @objc func doneAction(_ sender: Any) {
        if ( self.textView is UITextField ) { (self.textView as! UITextField).resignFirstResponder() }
        else if ( self.textView is UITextView ) { (self.textView as! UITextView).resignFirstResponder() }
    }
    
}
