//
//  MenuViewController.swift
//  ChaiGram
//
//  Created by Chaii on 21/06/23.
//

import UIKit
import PopupDialog

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func alerta1Click() {
        showPopUp(message: "Alerta 1 Manoseada")
    }
    
    @IBAction func alerta2Click() {
        showPopUp(message: "Alerta 2 Showeada")
    }
    
    @IBAction func alerta3Click() {
        showPopUp(message: "Alerta 3 Trikitrakatelas")
    }
    
    func showPopUp(message: String) {
        let popup = PopupDialog(title: "Side Menu Click", message: message)
        let dismissButton = CancelButton(title: "Ok", action: nil)
        popup.addButton(dismissButton)
        self.present(popup,animated: true,completion: nil)
    }


}
