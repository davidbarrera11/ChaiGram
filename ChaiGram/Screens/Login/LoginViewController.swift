//
//  LoginViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit
import PopupDialog
import Lottie

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loadingAnimation: LottieAnimationView!
    
    private let service: LoginServiceProtocol
    private var getRequestURL = ""

    init() {
        service = LoginService()
        super.init(nibName: "LoginViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingAnimation.isHidden = true
        title = " "
    }
    
    @IBAction func loginButtonClick(_ sender: Any) {
       
        guard let user = userTextField.text else {
            return
        }
        
        guard let password = passwordTextField.text else {
            return
        }
        
        guard let email = emailTextField.text else {
            return
        }
        
        let request =  RegisterRequest(username: user, email: email, password: password)
        loginUser(loginRequest: request)
        
    }
    
    func loginUser(loginRequest: RegisterRequest) {
        
        service.login(request: loginRequest) { result in
            self.loadSetup()
            self.loadingAnimation.isHidden = false
            
            switch result {
            case .success(let loginResult):
                print(loginResult.token)
                let homeViewController = HomeViewController(currentUser: loginRequest.username)
                let navController = UINavigationController(rootViewController: homeViewController)

                navController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(navController, animated: true)
                break
            case .failure(let error):
                self.showPopUp(message: Utils.errorMessages(error: error))
                break
            }
            

            
            
        }
    }
    
    private func loadSetup() {
        loadingAnimation.contentMode = .scaleAspectFit
        loadingAnimation.loopMode = .loop
        loadingAnimation.animationSpeed = 0.5
        loadingAnimation.play()
    }
    
    func showPopUp(message: String) {
        let popup = PopupDialog(title: "Request Error", message: message)
        let dismissButton = CancelButton(title: "Ok", action: nil)
        popup.addButton(dismissButton)
        self.present(popup,animated: true,completion: nil)
    }
    
  

}
