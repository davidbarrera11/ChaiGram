//
//  RegisterViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var service: RegisterService
    
    init() {
        service = RegisterService()
        super.init(nibName: "RegisterViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = " "
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        
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
        
        postUser(registerRequest: request)
    }
    
    func postUser(registerRequest: RegisterRequest){
        self.activityIndicator.startAnimating()
        service.postUser(request: registerRequest) { result in
            switch result {
            case .success(let registerResponse):
                self.activityIndicator.stopAnimating()
                let homeViewController = HomeViewController(currentUser: registerRequest.username)
                homeViewController.modalPresentationStyle = .fullScreen
                self.navigationController?.present(homeViewController, animated: true)
                break
            case .failure(let error):
                Utils.errorMessages(error: error)
                break
            }
        }
       
    }
    
   
    
}
