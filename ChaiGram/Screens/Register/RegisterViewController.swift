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
    
    private var urlRequest = "https://reqres.in/api/register"
    
    init() {
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
        
        guard let url = URL(string: urlRequest) else {
            return
        }
        
        activityIndicator.startAnimating()
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(registerRequest)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data else {
                return
            }
            
            do {
                let serializeData = try JSONDecoder().decode(RegisterResponse.self, from: data)
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                }
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
}
