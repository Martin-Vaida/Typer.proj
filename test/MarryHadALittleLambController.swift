//
//  TableViewController.swift
//  test
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class MarryHadALittleLambController:UITableViewController {
    var startingTime:Date = Date()
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    
    @IBOutlet weak var lineOne: UITextField!
    @IBOutlet weak var lineTow: UITextField!
    @IBOutlet weak var lineThree: UITextField!
    
    
    @IBAction func lineOneEnter(_ sender: Any) {
        lineOne.resignFirstResponder()
        lineTow.becomeFirstResponder()
        
    }
    
    @IBAction func lineTwoEnter(_ sender: Any) {
        lineTow.resignFirstResponder()
        lineThree.becomeFirstResponder()
        startingTime = Date()
        
    }
    
    @IBAction func lineThreeEnter(_ sender: Any) {
        
    }
    
    @IBAction func lineOneChaged(_ sender: Any) {
        let nowTime = Date()
        let deltaTime = Float(nowTime.timeIntervalSince(startingTime))
        
        navigationItem.title = String(deltaTime)
    }
    
    
}
