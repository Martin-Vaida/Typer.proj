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
        
        nameTextField.text = MenuViewController.userName
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        MenuViewController.userName = nameTextField.text ?? "user"
        let account = Account(name: MenuViewController.userName)
        Account.save(account)
    }
    
}
