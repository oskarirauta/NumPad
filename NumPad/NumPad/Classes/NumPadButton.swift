//
//  NumPadButton.swift
//  NumPad
//
//  Created by Oskari Rauta on 04/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import Foundation

extension NumPad {
    
    public class NumPadButton: UIButton {
        
        public var handler: ((Int) -> Void)? = nil
        public var timer: Timer? = nil
        private(set) var style: NumPad.Style = NumPad.Style.default
        private(set) var type: NumPad.KeyboardType = .number
        private(set) var count: Int = 0
        
        override public var isHighlighted: Bool {
            didSet { UIView.animate(withDuration: 0.08, animations: {
                self.backgroundColor = self.isHighlighted ? self.style.backgroundColorHighlighted : self.style.backgroundColor }) }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public init(type: NumPad.KeyboardType, style: NumPad.Style = NumPad.Style.default, title: String, tag: Int, handler: ((Int) -> Void)? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.style = style
            self.type = type
            self.tag = tag
            self.handler = handler
            
            self.layer.cornerRadius = 9.0
            self.layer.masksToBounds = false
            self.layer.borderWidth = 0.0
            self.layer.shadowColor = self.style.shadowColor.cgColor
            self.layer.shadowOpacity = 0.9
            self.layer.shadowRadius = 1.0
            self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            
            self.backgroundColor = self.isHighlighted ? self.style.backgroundColorHighlighted : self.style.backgroundColor
            self.setTitleColor(self.style.foregroundColor, for: .normal)
            self.setTitleColor(self.style.foregroundColorHighlighted, for: .highlighted)
            self.titleLabel?.font = self.style.font
            self.titleLabel?.textAlignment = .center
            self.titleLabel?.lineBreakMode = .byClipping
            self.isEnabled = true
            
            self.titleLabel?.numberOfLines = (( type == .phone ) && ( UIDevice.current.orientation.isPortrait )) ? 2 : 1
            
            let buttonTitle: NSMutableAttributedString = NSMutableAttributedString(string: title, attributes: [
                .font: type == .phone ? style.phoneCharFont : style.font
                ])
            
            if ( type == .phone ) {
                buttonTitle.setAttributes([ .font: style.phoneFont ], range: NSRange(location: 0, length: 1))
            }
            
            self.setAttributedTitle(buttonTitle, for: UIControlState())
            
            self.addTarget(self, action: #selector(self.buttonDown), for: .touchDown)
            self.addTarget(self, action: #selector(self.buttonUp), for: .touchUpInside)
            self.addTarget(self, action: #selector(self.buttonUp), for: .touchUpOutside)
        }
        
        @objc internal func buttonUp() {
            self.timer?.invalidate()
            self.timer = nil
            self.count = 0
        }
        
        @objc internal func buttonDown() {
            self.handler?(self.tag)
            self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.buttonDownAgain), userInfo: nil, repeats: false)
            self.count = 1
        }
        
        @objc internal func buttonDownAgain() {
            self.timer?.invalidate()
            self.handler?(self.tag)
            self.count += 1
            self.timer = Timer.scheduledTimer(timeInterval: self.count > 4 ? 0.15 : 0.35, target: self, selector: #selector(self.buttonDownAgain), userInfo: nil, repeats: false)
        }
    }
    
    public class NumPadFunctionButton: UIButton {
        
        public var handler: ((Int) -> Void)? = nil
        private(set) var style: NumPad.Style = NumPad.Style.default
        private(set) var type: NumPad.KeyboardType = .number
        
        override public var isEnabled: Bool {
            didSet { self.setTitleColor(self.isEnabled ? self.style.foregroundColor : self.style.foregroundColorHighlighted, for: .normal) }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public init(style: NumPad.Style = NumPad.Style.default, type: NumPad.KeyboardType, handler: ((Int) -> Void)? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            
            self.type = type
            self.style = style
            self.tag = 10
            self.backgroundColor = UIColor.clear
            self.setTitleColor(style.foregroundColor, for: .normal)
            self.setTitleColor(style.foregroundColorHighlighted, for: .highlighted)
            self.titleLabel?.font = style.font
            self.titleLabel?.textAlignment = .center
            switch type {
            case .decimal: self.setTitle(NumPad.decimalChar, for: UIControlState())
            case .phone: self.setTitle("+", for: UIControlState())
            default: self.setTitle("", for: UIControlState())
            }
            self.isEnabled = type == .number ? false : true
            self.handler = handler
            self.addTarget(self, action: #selector(self.buttonDown), for: .touchDown)
        }
        
        @objc internal func buttonDown() {
            self.handler?(self.tag)
        }
    }
    
    public class NumPadBackspaceButton: UIButton {
        
        public var handler: ((Int) -> Void)? = nil
        public var timer: Timer? = nil
        private(set) var style: NumPad.Style = NumPad.Style.default
        private(set) var count: Int = 0
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        public init(style: NumPad.Style = NumPad.Style.default, handler: ((Int) -> Void)? = nil) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.setImage(UIImage(named: "Backspace", in: Bundle(for: NumPad.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: UIControlState())
            self.showsTouchWhenHighlighted = true
            self.style = style
            self.tag = 11
            self.backgroundColor = UIColor.clear
            self.tintColor = style.backspaceColor
            self.handler = handler
            self.addTarget(self, action: #selector(self.buttonDown), for: .touchDown)
            self.addTarget(self, action: #selector(self.buttonUp), for: .touchUpInside)
            self.addTarget(self, action: #selector(self.buttonUp), for: .touchUpOutside)
        }
        
        @objc internal func buttonUp() {
            self.timer?.invalidate()
            self.timer = nil
            self.count = 0
        }
        
        @objc internal func buttonDown() {
            self.handler?(self.tag)
            self.timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(self.buttonDownAgain), userInfo: nil, repeats: false)
            self.count = 1
        }
        
        @objc internal func buttonDownAgain() {
            self.timer?.invalidate()
            self.handler?(self.tag)
            self.count += 1
            self.timer = Timer.scheduledTimer(timeInterval: self.count > 4 ? 0.15 : 0.35, target: self, selector: #selector(self.buttonDownAgain), userInfo: nil, repeats: false)
        }
    }
    
}

