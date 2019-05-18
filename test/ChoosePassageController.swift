//
//  ChoosePassageController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/9.
//  Copyright © 2019 Vaida. All rights reserved.
//

import Foundation
import UIKit

class ChoosePassageController:UITableViewController {
    
    @IBAction func unwindToChoosePassage(segue:UIStoryboardSegue) {
        guard segue.identifier == "MarryHadALittleLambReturn" else { return }
    }
}
