//
//  AnimatedViewController.swift
//  ChaiGram
//
//  Created by Chaii on 21/06/23.
//

import UIKit
import Lottie

enum ProgressFrames: CGFloat {
    case start = 20
    case end = 90
}

class AnimatedViewController: UIViewController {
    
    @IBOutlet weak var chaiGram: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chaiSetup()
        
        // Do any additional setup after loading the view.
    }
    
    private func chaiSetup() {
        chaiGram.contentMode = .scaleAspectFit
        chaiGram.loopMode = .playOnce
        chaiGram.animationSpeed = 0.5
        chaiGram.play{ (finished) in
            self.chaiGram!.isHidden = true
            self.welcomeScreen()
        }

    }
    
    private func welcomeScreen() {
        let welcomeViewController = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeViewController)
        navController.modalPresentationStyle = .fullScreen
        navController.modalTransitionStyle = .crossDissolve
        self.navigationController?.present(navController, animated: true)    }
    
}
