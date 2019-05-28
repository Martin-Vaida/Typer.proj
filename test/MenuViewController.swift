//
//  MenuViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController:UIViewController {
    
    @IBAction func unwindToMenu(segue:UIStoryboardSegue) {
        
    }
    
    static var studentsMode = false
    static var forceQuite = false
    static var userName = "user"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorMixViewController.colorArray.append(UIColorß("0.5", "0.5", "0.5", "1"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "1"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        colorMixViewController.colorArray.append(UIColorß("0", "0", "0", "0.2"))
        
        if Score.load() != nil {
            scoresView.scoreCollection = Score.load()!
            scoresViewHasSet = true
        }
        
        if UIColorß.load() != nil {
            colorMixViewController.colorArray = UIColorß.load()!
        }
        
        if StudentsMode.load() != nil {
            MenuViewController.studentsMode = StudentsMode.load()!.isOn
            MenuViewController.forceQuite = StudentsMode.load()!.autoStop
        }
        
        if Account.load() != nil {
            MenuViewController.userName = Account.load()!.name
        }
        
    }
    
}
