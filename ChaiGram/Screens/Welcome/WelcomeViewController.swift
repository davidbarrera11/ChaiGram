//
//  WelcomeViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    init() {
        super.init(nibName: "WelcomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func registerButtonClick(_ sender: Any) {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
}
