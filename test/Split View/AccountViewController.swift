//
//  AccountViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class AccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        botton.isOn = MenuViewController.developerMode
        nameTextField.text = MenuViewController.userName
        
        nameTextField.text = MenuViewController.userName
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        MenuViewController.userName = nameTextField.text ?? "user"
        let account = Account(name: MenuViewController.userName, developer:  MenuViewController.developerMode)
        Account.save(account)
    }
    
    @IBOutlet weak var botton: UISwitch!
    @IBAction func bottonTapped(_ sender: Any) {
        var correct = false
        let alertController = UIAlertController(title: "Confirm Admin", message: nil, preferredStyle: .alert)
        let adminName = "Martin-Vaida"
        let passcode = "Mv0123456789"
        alertController.addTextField { (textField) in
            textField.placeholder = "Administrator Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Passcode"
            textField.isSecureTextEntry = true
        }
        let confirmActoin = UIAlertAction(title: "Confirm", style: .cancel) { (_) in
            if alertController.textFields!.first!.text! == adminName {
                correct = true
            } else {
                correct = false
            }
            
            if alertController.textFields!.last!.text! == passcode {
                correct = true
            } else {
                correct = false
            }
            
            if correct {
                MenuViewController.developerMode = true
            } else {
                MenuViewController.developerMode = false
                self.botton.isOn = false
            }
        }
        alertController.addAction(confirmActoin)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//All rights reserved.
