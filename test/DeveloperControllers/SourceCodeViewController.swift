//
//  showSourceCode.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/18.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class SourceCodeViewController:UIViewController {
    
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.isEditable = false
        
        switch SourceTableViewController.target {
        case .MenuViewController:
            textField.text = SourceCode.MenuViewController
        case .scoresView:
            textField.text = SourceCode.scoresView
        case .Score:
            textField.text = SourceCode.Score
        case .ChoosePassageController:
            textField.text = SourceCode.ChoosePassageController
        case .ColorMixViewController:
            textField.text = SourceCode.ColorMixViewController
        case .DetailViewController:
            textField.text = SourceCode.DetailViewController
        case .MaryHadALittleLambController:
            textField.text = SourceCode.maryHadALittlelambViewController
        case .MasterViewController:
            textField.text = SourceCode.MasterViewController
        case .MasterViewControllerCell:
            textField.text = SourceCode.MasterViewControllerCell
        case .scoresViewCell:
            textField.text = SourceCode.scoresViewCell
        case .ScoreViewController:
            textField.text = SourceCode.ScoreViewController
        case .StatisticsViewController:
            textField.text = SourceCode.StatisticsViewController
        }
    }
}

//All rights reserved.
