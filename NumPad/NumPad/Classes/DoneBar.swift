//
//  DoneBar.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

public final class DoneBar: UIToolbar {

    private(set) var inputViewType: NumPad.InputViewType? = nil
    private(set) weak var textInput: UITextInput? = nil

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textInput = nil
        self.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:)))
        ]
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setupTextInput(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)
    }
    
    @objc internal func setupTextInput(_ notification: Notification) {
        
        guard
            let textInput: UITextInput = notification.object as? UITextInput,
            ( self == (textInput as? UITextField)?.inputAccessoryView || self == (textInput as? UITextView)?.inputAccessoryView )
            else { return }
        
        self.textInput = textInput
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidBeginEditing, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
        
        self.inputViewType = notification.name == NSNotification.Name.UITextFieldTextDidBeginEditing ? .textField : .textView
    }

    
    @objc func doneAction(_ sender: Any) {
        
        guard
            let textInput: UITextInput = self.textInput,
            let inputViewType: NumPad.InputViewType = self.inputViewType
            else { return }
        
        switch inputViewType {
        case .textField:
            (textInput as! UITextField).resignFirstResponder()
            NotificationCenter.default.post(name: Notification.Name.UITextFieldTextDidEndEditing, object: textInput as! UITextField)
        case .textView:
            (textInput as! UITextView).resignFirstResponder()
            NotificationCenter.default.post(name: Notification.Name.UITextViewTextDidEndEditing, object: textInput as! UITextView)
        }
    }
    
}
