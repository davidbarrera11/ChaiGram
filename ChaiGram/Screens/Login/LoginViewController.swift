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
    
    private var getRequestURL = ""

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
        guard let url = URL(string: Endpoints.login.url) else {
            return
        }
        
        activityIndicator.startAnimating()
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(loginRequest)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data else {
                return
            }
            
            do {
                let serializeData = try JSONDecoder().decode(LoginResponse.self, from: data)
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                    let homeViewController = HomeViewController(currentUser: loginRequest.username)
                    homeViewController.modalPresentationStyle = .fullScreen
                    self.navigationController?.present(homeViewController, animated: true)
                }
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
        
    }

}
