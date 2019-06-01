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
        case .KingsmanIViewController:
            textField.text = SourceCode.KingsmanIViewContrioller
        case .KingsmanIIViewController:
            textField.text = SourceCode.KingsmanIIViewController
        case .StoryViewController:
            textField.text = SourceCode.StoryViewContrioller
        case .RandomViewController:
            textField.text = SourceCode.RandomViewController
        case .gameViewController:
            textField.text = SourceCode.gameViewController
        case .ITViewController:
            textField.text = SourceCode.ITViewController
        case .LightViewController:
            textField.text = SourceCode.LightViewController
        case .LightController:
            textField.text = SourceCode.LightController
        case .Support:
            textField.text = SourceCode.support
        case .StudentsMode:
            textField.text = SourceCode.StudentsMode
        case .UIColorß:
            textField.text = SourceCode.UIColorß
        case .AccountViewController:
            textField.text = SourceCode.AccountViewController
        case .Account:
            textField.text = SourceCode.Account
        case .PassedStudentsViewController:
            textField.text = SourceCode.PassedStudentsViewController
        case .PassedStudentsCell:
            textField.text = SourceCode.passedStudentsCell
        }
    }
}

//All rights reserved.
