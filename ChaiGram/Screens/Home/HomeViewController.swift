//
//  HomeViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    let updateButton = UIButton(type: .custom)
    let namesTextField = UITextField()
    
    let userName: String

    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo(userName: userName)

        //updateButton.frame = CGRect(x: 150, y: 30, width: 200, height:  30)
        updateButton.setTitle("Update name", for: .normal)
        updateButton.backgroundColor = .blue
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.addTarget(self, action: #selector(updateButtonClick), for: .touchUpInside)
        
        namesTextField.placeholder = "INGRESA TU NOMBRE :3"
        namesTextField.layer.borderWidth = 0.5
        
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: updateButton, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: updateButton, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: updateButton, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -10),
            NSLayoutConstraint(item: updateButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50),
            NSLayoutConstraint(item: namesTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)

        ])
        
        stackView.addArrangedSubview(namesTextField)
    }
    
    init(currentUser: String) {
        userName = currentUser
        super.init(nibName: "HomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getUserInfo(userName: String) {
        
        guard let url = URL(string: Endpoints.getUser(user: userName).url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data else {
                return
            }
            
            do {
                let serializeData = try JSONDecoder().decode(UserProfile.self, from: data)
                DispatchQueue.main.async{
                    self.showUserInfo(user: serializeData)
                }
                
            } catch {
                print(error)
            }
            
        }
        task.resume()
    }
    
    private func showUserInfo(user: UserProfile) {
        userLabel.text = user.username
        emailLabel.text = user.email
    }
    
    @objc private func updateButtonClick() {
        print("Me manosearon")
    }
}
