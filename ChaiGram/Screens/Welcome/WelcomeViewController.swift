//
//  WelcomeViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit
import Lottie
import SideMenu

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    init() {
        super.init(nibName: "WelcomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeSetUp()
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
    
    @IBAction func showMenu(_ sender: Any) {
        let menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu.leftSide = true
        present(menu, animated: true, completion: nil)
    }
    
    private func welcomeSetUp() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
    }
    
}
