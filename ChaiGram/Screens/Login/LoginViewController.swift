//
//  LoginViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class LoginViewController: UIViewController {

    init() {
        super.init(nibName: "LoginViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
    }

}
