//
//  LightViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/28.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class LightViewController:UITableViewController {
    @IBOutlet var introductionLabel: [UILabel]!     //seven objects
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        for i in introductionLabel {
            i.text = "//  "
        }
        introductionLabel[1].text! += "ViewController.swift"
        introductionLabel[2].text! += "Light"
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "zh_CN")
        let takenDate = String(dateFormatter.string(from: Date()))
        introductionLabel[4].text! += "Created by \(MenuViewController.userName) on \(takenDate)."
        
    }
    
}
