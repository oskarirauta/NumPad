//
//  ViewController.swift
//  NumPadExample
//
//  Created by Oskari Rauta on 04/05/2018.
//  Copyright © 2018 Oskari Rauta. All rights reserved.
//

import UIKit
import NumPad

class ViewController: UIViewController, UITextFieldDelegate {
    
    lazy var tf1: UITextField = {
        var _tf: UITextField = UITextField(frame: .zero)
        _tf.translatesAutoresizingMaskIntoConstraints = false
        _tf.borderStyle = .roundedRect
        _tf.delegate = self
        _tf.placeholder = "Number"
        _tf.inputView = NumPad(delegate: _tf, type: .number)
        _tf.inputAccessoryView = DoneBar(delegate: _tf)
        return _tf
    }()

    lazy var tf2: UITextField = {
        var _tf: UITextField = UITextField(frame: .zero)
        _tf.translatesAutoresizingMaskIntoConstraints = false
        _tf.borderStyle = .roundedRect
        _tf.delegate = self
        _tf.placeholder = "Decimal"
        _tf.inputView = NumPad(delegate: _tf, type: .decimal)
        _tf.inputAccessoryView = DoneBar(delegate: _tf)
        return _tf
    }()

    lazy var tf3: UITextField = {
        var _tf: UITextField = UITextField(frame: .zero)
        _tf.translatesAutoresizingMaskIntoConstraints = false
        _tf.borderStyle = .roundedRect
        _tf.delegate = self
        _tf.placeholder = "Phone"
        _tf.inputView = NumPad(delegate: _tf, type: .phone)
        _tf.inputAccessoryView = DoneBar(delegate: _tf)
        return _tf
    }()

    lazy var tf4: UITextField = {
        var _tf: UITextField = UITextField(frame: .zero)
        _tf.translatesAutoresizingMaskIntoConstraints = false
        _tf.borderStyle = .roundedRect
        _tf.delegate = self
        _tf.placeholder = "Text"
        _tf.inputAccessoryView = DoneBar(delegate: _tf)
        return _tf
    }()

    lazy var dismissBtn: UIButton = {
        var _btn: UIButton = UIButton(frame: .zero)
        _btn.translatesAutoresizingMaskIntoConstraints = false
        _btn.setTitle("Dismiss", for: UIControlState())
        _btn.isEnabled = false
        _btn.setTitleColor(UIColor.blue, for: .normal)
        _btn.setTitleColor(UIColor.lightGray, for: .disabled)
        _btn.setTitleColor(UIColor.darkGray, for: .highlighted)
        _btn.addTarget(self, action: #selector(self.btnAction), for: .touchUpInside)
        return _btn
    }()

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

