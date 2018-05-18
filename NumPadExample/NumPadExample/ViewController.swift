//
//  ViewController.swift
//  NumPadExample
//
//  Created by Oskari Rauta on 04/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import NumPad
import CommonKit
import PhoneNumberKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    lazy var phone_del: PhoneNumberFieldDelegate = PhoneNumberFieldDelegate.create {
        $0.subDelegate = self
    }
    
    lazy var tf1: UITextField = UITextField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.delegate = self
        $0.placeholder = "Number"
        $0.inputView = NumPad() // Defaults to .number
        $0.inputAccessoryView = DoneBar()
        }

    lazy var tf2: UITextField = UITextField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.delegate = self
        $0.placeholder = "Decimal"
        $0.inputView = NumPad(type: .decimal)
        $0.inputAccessoryView = DoneBar()
    }

    lazy var tf3: UITextField = UITextField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.delegate = self.phone_del
        $0.placeholder = "Phone (with formatting)"
        $0.inputView = NumPad(type: .phone)
        $0.inputAccessoryView = DoneBar()
    }

    lazy var tf4: UITextField = UITextField.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.borderStyle = .roundedRect
        $0.delegate = self
        $0.placeholder = "Text with DoneBar"
        $0.inputAccessoryView = DoneBar()
    }

    lazy var dismissBtn: UIButton = UIButton.create {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Dismiss", for: UIControlState())
        $0.isEnabled = false
        $0.setTitleColor(UIColor.blue, for: .normal)
        $0.setTitleColor(UIColor.lightGray, for: .disabled)
        $0.setTitleColor(UIColor.darkGray, for: .highlighted)
        $0.addTarget(self, action: #selector(self.btnAction), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        [self.tf1, self.tf2, self.tf3, self.tf4].forEach {
            
            self.view.addSubview($0)

            $0.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20.0).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 28.0).isActive = true
        }

        self.tf1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 28.0).isActive = true
        self.tf2.topAnchor.constraint(equalTo: self.tf1.bottomAnchor, constant: 15.0).isActive = true
        self.tf3.topAnchor.constraint(equalTo: self.tf2.bottomAnchor, constant: 15.0).isActive = true
        self.tf4.topAnchor.constraint(equalTo: self.tf3.bottomAnchor, constant: 15.0).isActive = true

        self.view.addSubview(self.dismissBtn)
        
        self.dismissBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.dismissBtn.topAnchor.constraint(equalTo: self.tf4.bottomAnchor, constant: 15.0).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dismissBtn.isEnabled = true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.dismissBtn.isEnabled = false
        return true
    }
    
    @IBAction func btnAction() {
        [self.tf1, self.tf2, self.tf3, self.tf4].forEach {
            if ( $0.isFirstResponder ) { $0.resignFirstResponder() }
        }
    }

}

