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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard Score.load() != nil else { return }
        scoresView.scoreCollection = Score.load()!
        scoresViewHasSet = true
        
        
    }
}
