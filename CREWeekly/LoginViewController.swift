//
//  LoginViewController.swift
//  CREWeekly
//
//  Created by Feihong Zhao on 2017-08-22.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit
import SnapKit
import iMaster

class LoginViewController: UIViewController {
    
    var textField: UITextView = {
        let tV = UITextView()
        return tV
    }()
    
    var loginButton: UIButton = {
        let bt = UIButton(type: UIButtonType.system)
        bt.setTitle("LOGIN", for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
}
