//
//  NumPadExtension.swift
//  NumPad
//
//  Created by Oskari Rauta on 05/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension NumPad {
            
    internal func setupViews() {
        self.addSubview(self.overlayView)
        self.overlayView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.overlayView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.overlayView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.overlayView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.overlayView.addSubview(self.innerView)
        self.innerView.topAnchor.constraint(equalTo: self.overlayView.topAnchor).isActive = true
        self.innerView.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor).isActive = true
        self.innerView.leadingAnchor.constraint(equalTo: self.overlayView.leadingAnchor).withPriority(999).isActive = true
        self.innerView.trailingAnchor.constraint(equalTo: self.overlayView.trailingAnchor).withPriority(999).isActive = true
        self.innerView.bottomAnchor.constraint(equalTo: self.overlayView.bottomAnchor).isActive = true
        self.innerView.widthAnchor.constraint(lessThanOrEqualToConstant: 360.0).withPriority(1000).isActive = true
        
        guard self.button.count == 0 else { return }
        
        let buttonTitles: [String] = self.type == .phone ? [
            "0",
            "1\n",
            "2\nABC",
            "3\nDEF",
            "4\nGHI",
            "5\nJKL",
            "6\nMNO",
            "7\nPQRS",
            "8\nTUV",
            "9\nWXYZ"
            ] : [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" ]
        
        for i in 0...9 {
            self.button.append(NumPadButton(type: self.type, style: self.style, title: buttonTitles[i], tag: i, handler: self.buttonHandler(_:)))
        }
        
        self.button.append(NumPadFunctionButton(style: self.style, type: self.type, handler: self.buttonHandler(_:)))
        self.button.append(NumPadBackspaceButton(style: self.style, handler: self.buttonHandler(_:)))
        
        self.button.forEach { self.innerView.addSubview($0) }
        
        self.button[2].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[5].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[8].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        self.button[0].centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        self.button[1].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        self.button[2].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        self.button[3].topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: 6.0).isActive = true
        
        self.button[1].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        self.button[4].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        self.button[7].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 9.0).isActive = true
        
        self.button[3].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        self.button[6].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        self.button[9].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        
        self.button[10].leadingAnchor.constraint(equalTo: self.innerView.leadingAnchor, constant: 12.0).isActive = true
        self.button[11].trailingAnchor.constraint(equalTo: self.innerView.trailingAnchor, constant: -12.0).isActive = true
        
        self.button[1].trailingAnchor.constraint(equalTo: self.button[2].leadingAnchor, constant: -12.0).isActive = true
        self.button[4].trailingAnchor.constraint(equalTo: self.button[5].leadingAnchor, constant: -12.0).isActive = true
        self.button[7].trailingAnchor.constraint(equalTo: self.button[8].leadingAnchor, constant: -12.0).isActive = true
        
        self.button[3].leadingAnchor.constraint(equalTo: self.button[2].trailingAnchor, constant: 9.0).isActive = true
        self.button[6].leadingAnchor.constraint(equalTo: self.button[5].trailingAnchor, constant: 9.0).isActive = true
        self.button[9].leadingAnchor.constraint(equalTo: self.button[8].trailingAnchor, constant: 9.0).isActive = true
        
        self.button[4].topAnchor.constraint(equalTo: self.button[1].bottomAnchor, constant: 12.0).isActive = true
        self.button[5].topAnchor.constraint(equalTo: self.button[2].bottomAnchor, constant: 12.0).isActive = true
        self.button[6].topAnchor.constraint(equalTo: self.button[3].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[7].topAnchor.constraint(equalTo: self.button[4].bottomAnchor, constant: 12.0).isActive = true
        self.button[8].topAnchor.constraint(equalTo: self.button[5].bottomAnchor, constant: 12.0).isActive = true
        self.button[9].topAnchor.constraint(equalTo: self.button[6].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[10].trailingAnchor.constraint(equalTo: self.button[0].leadingAnchor, constant: -12.0).isActive = true
        self.button[11].leadingAnchor.constraint(equalTo: self.button[0].trailingAnchor, constant: 12.0).isActive = true
        
        self.button[10].topAnchor.constraint(equalTo: self.button[7].bottomAnchor, constant: 12.0).isActive = true
        self.button[0].topAnchor.constraint(equalTo: self.button[8].bottomAnchor, constant: 12.0).isActive = true
        self.button[11].topAnchor.constraint(equalTo: self.button[9].bottomAnchor, constant: 12.0).isActive = true
        
        self.button[0].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        self.button[10].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        self.button[11].bottomAnchor.constraint(equalTo: self.innerView.bottomAnchor, constant: -8.0).isActive = true
        
        self.button.enumerated().forEach {
            guard $0 != 0, $0 < 10 else { return }
            $1.widthAnchor.constraint(equalTo: self.button[0].widthAnchor).isActive = true
            $1.heightAnchor.constraint(equalTo: self.button[0].heightAnchor).isActive = true
        }
    }
    
    internal func postUpdate() {

        guard
            let inputViewType: InputViewType = self.inputViewType,
            let textInput: UITextInput = self.textInput
            else { return }

        NotificationCenter.default.post(name: inputViewType == .textField ? NSNotification.Name.UITextFieldTextDidChange : NSNotification.Name.UITextViewTextDidChange, object: inputViewType == .textField ? (textInput as! UITextField) : (textInput as! UITextView))
    }
    
    internal func updateState() {
        
        if ((!( self.textInput?.hasText ?? false )) && ( self.button[11].isEnabled )) {
            (self.button[11] as! NumPadBackspaceButton).timer?.invalidate()
            (self.button[11] as! NumPadBackspaceButton).timer = nil
        }
        
        self.button[11].isEnabled = self.textInput?.hasText ?? false
        
        if ( self.type == .decimal ) {
            self.button[10].isEnabled = (self.value?.contains(self.decimalChar) ?? false) ? false : true
        } else if ( self.type == .phone ) {
            self.button[10].isEnabled = ( self.value?.count ?? 0 ) > 0 ? false : true
        }
    }

    internal func shouldChangeText(in range: UITextRange?, replacementText: String) -> Bool {
        
        guard
            let range: UITextRange = range,
            let inputViewType: InputViewType = self.inputViewType,
            let textInput: UITextInput = self.textInput
            else { return false }
        
        let nsrange: NSRange = NSRange(location: textInput.offset(from: textInput.beginningOfDocument, to: range.start), length: textInput.offset(from: range.start, to: range.end))
        
        switch inputViewType {
        case .textField:
            if let textField: UITextField = textInput as? UITextField, !( textField.delegate?.textField?(textField, shouldChangeCharactersIn: nsrange, replacementString: replacementText) ?? textField.shouldChangeText(in: range, replacementText: replacementText)) {
                return false
            }
        case .textView:
            if let textView: UITextView = textInput as? UITextView, !( textView.delegate?.textView?(textView, shouldChangeTextIn: nsrange, replacementText: replacementText) ?? textView.shouldChangeText(in: range, replacementText: replacementText )) {
                return false
            }
        }

        return true
    }
    
    internal func replace(_ range: UITextRange?, withText: String) {
        
        guard
            let range: UITextRange = range,
            let textInput: UITextInput = self.textInput,
            let inputViewType: InputViewType = self.inputViewType,
            self.shouldChangeText(in: range, replacementText: withText)
            else { return }
        
        switch inputViewType {
        case .textField: (textInput as! UITextField).replace(range, withText: withText)
        case .textView: (textInput as! UITextView).replace(range, withText: withText)
        }
    }
    
    internal func buttonHandler(_ tag: Int) {
        
        if ( self.enableInputClicksWhenVisible ) {
            UIDevice.current.playInputClick()
        }
        
        let buttonsValues: [String] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let functionChar: String = self.type == .decimal ? (( self.value?.isEmpty ?? true ) ? ( "0" + self.decimalChar ) : self.decimalChar ) : "+"
        
        switch tag {
        case let (x) where x < 10:
            
            self.replace(self.textInput?.selectedTextRange, withText: buttonsValues[tag])
            self.postUpdate()
            
        case 10: // Type variadic function key
            self.replace(self.textInput?.selectedTextRange, withText: functionChar)
            self.postUpdate()
            
        case 11: // Backspace
            guard
                let textInput: UITextInput = textInput,
                let from: UITextPosition = textInput.position(from: textInput.beginningOfDocument, offset: self.cursorOffset - 1),
                let to: UITextPosition = textInput.position(from: textInput.beginningOfDocument, offset: self.cursorOffset),
                let range: UITextRange = textInput.textRange(from: from, to: to),
                self.shouldChangeText(in: range, replacementText: "")
                else { return }
            
            self.replace(range, withText: "")
            self.postUpdate()
            
        default:
            break
        }
        
        self.updateState()
    }

    
}
