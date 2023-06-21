//
//  HomeViewController.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import UIKit

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    private var service: HomeService
    private var images = [UIImage]()
    
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
        service = HomeService()
        userName = currentUser
        super.init(nibName: "HomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        photoImageView.image = image
        images.append(image)
    }
    
    private func getUserInfo(userName: String) {
        
        service.getUserInfo(userName: userName) { result in
            switch result {
            case .success(let userInfo):
                self.showUserInfo(user: userInfo)
                break
            case .failure(let error):
                Utils.errorMessages(error: error)
                break
            }
        }
          
    }
    
    @IBAction func logoutClick() {
        let welcomeViewController = WelcomeViewController()
        welcomeViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(welcomeViewController, animated: true)
    }
    
    @IBAction func activateCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @IBAction func openGallery() {
        let galleryViewController = GalleryViewController(datasource: images)
        galleryViewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(galleryViewController, animated: true)
    }
    
    private func showUserInfo(user: UserProfile) {
        userLabel.text = user.username
        emailLabel.text = user.email
    }
    
    @objc private func updateButtonClick() {
        
        guard let user = userLabel.text else {
            return
        }
        
        guard let names = namesTextField.text else {
            return
        }
        
        let request = PutNameBody(username: user, names: names)
        putUser(putRequest: request)
    }
    
    func putUser(putRequest: PutNameBody){
        service.putUser(request: putRequest) { result in
            switch result {
            case .success(let registerResponse):
                print(registerResponse)
                break
            case .failure(let error):
                Utils.errorMessages(error: error)
                break
            }
        }
       
    }
}
