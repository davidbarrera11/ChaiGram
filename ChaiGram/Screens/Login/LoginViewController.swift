//
//  LoginViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
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
        activityIndicator.startAnimating()
        
        service.login(request: loginRequest) { result in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let loginRequest):
                print(loginRequest.token)
                break
            case .failure(let error):
                Utils.errorMessages(error: error)
                break
            }
            

            let homeViewController = HomeViewController(currentUser: loginRequest.username)
            let navController = UINavigationController(rootViewController: homeViewController)

            navController.modalPresentationStyle = .fullScreen
            self.navigationController?.present(navController, animated: true)
            
        }
    }
    
  

}
