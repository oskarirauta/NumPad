//
//  NumPad.swift
//  NumPad
//
//  Created by Oskari Rauta on 04/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

open class NumPad: UIInputView, UIInputViewAudioFeedback {

    private(set) var type: KeyboardType = .number
    private(set) var style: Style = Style.default

    lazy internal var overlayView: UIView = {
        var _overlayView: UIView = UIView()
        _overlayView.translatesAutoresizingMaskIntoConstraints = false
        _overlayView.backgroundColor = self.style.overlayColor
        return _overlayView
    }()
    
    lazy internal var innerView: UIView = {
        var _innerView: UIView = UIView()
        _innerView.translatesAutoresizingMaskIntoConstraints = false
        _innerView.backgroundColor = UIColor.clear
        return _innerView
    }()

    internal var button: [UIButton] = []
    internal weak var textView: UITextInput?

    public init(delegate: UITextInput, type: KeyboardType = KeyboardType.number, style: NumPad.Style = NumPad.Style.default) {
        super.init(frame: .zero, inputViewStyle: .default)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.type = type
        self.style = style
        self.textView = delegate
        self.setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
    }
    
    private override init(frame: CGRect, inputViewStyle: UIInputViewStyle) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
    }
        
    open var enableInputClicksWhenVisible: Bool {
        get { return true }
    }
 
    open override var intrinsicContentSize: CGSize {
        get { return CGSize(width: UIViewNoIntrinsicMetric, height: UIViewNoIntrinsicMetric) }
    }
    
    open var notificationName: NSNotification.Name? {
        get {
            if ( self.textView is UITextField ) { return NSNotification.Name.UITextFieldTextDidChange }
            else if ( self.textView is UITextView ) { return NSNotification.Name.UITextViewTextDidChange }
            else { return nil }
        }
    }
    
    open static var decimalChar: String {
        get { return Locale.autoupdatingCurrent.decimalSeparator ?? "." }
    }
    
    open var decimalChar: String {
        get { return NumPad.decimalChar }
    }
    
    internal var value: String? {
        get {
            guard
                let textView: UITextInput = self.textView,
                let range: UITextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.endOfDocument)
                else { return nil }

            return textView.text(in: range)
        }
    }
        
    open override func willMove(toSuperview newSuperview: UIView?) {
        
        super.willMove(toSuperview: newSuperview)
        
        guard newSuperview != nil else {
            
            if (( self.value == self.decimalChar ) || ( self.value == "+" )) {
                let range: UITextRange = self.textView!.textRange(from: self.textView!.beginningOfDocument, to: self.textView!.endOfDocument)!
                self.textView!.replace(range, withText: "")
            } else if (( self.type == .decimal ) && ( self.value?.first == self.decimalChar.first ) && ( self.decimalChar.first != nil )) {
                let range: UITextRange = self.textView!.textRange(from: self.textView!.beginningOfDocument, to: self.textView!.position(from: self.textView!.beginningOfDocument, offset: 1)!)!
                self.textView!.replace(range, withText: "0" + self.decimalChar)
            } else if (( self.type == .phone ) && (( self.value?.contains("+") ?? false))) {
                let beginsWithPlus: Bool = self.value?.first == "+" ? true : false
                let newText: String = ( beginsWithPlus ? "+" : "" ) + self.value!.replacingOccurrences(of: "+", with: "")
                let range: UITextRange = self.textView!.textRange(from: self.textView!.beginningOfDocument, to: self.textView!.endOfDocument)!
                self.textView!.replace(range, withText: newText != "+" ? newText : "" )
            }
            return
        }
        self.updateState()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard self.type == .phone else { return }
        let numberOfLines: Int = UIDevice.current.orientation.isPortrait ? 2 : 1
        self.button.enumerated().forEach {
            guard $0 < 10 else { return }
            $1.titleLabel?.numberOfLines = numberOfLines
        }
    }

}
