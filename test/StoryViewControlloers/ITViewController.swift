//
//  ITViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class ITViewController:UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard !MenuViewController.developerMode else { return }
        let alertController = UIAlertController(title: "Notice", message: "In this mode, \n we will build apps together. \n Try to type in the code, \n and some easy apps will be built.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Next time maybe", style: .cancel) { (_) in
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Choose_Passage_View") as! ChoosePassageController
            self.navigationController!.pushViewController(viewController, animated: true)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
