//
//  SourceTabelViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/18.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class SourceTableViewController:UITableViewController {
    enum Target {
        case MenuViewController
        case scoresView
        case Score
        case scoresViewCell
        case ChoosePassageController
        case ScoreViewController
        case MasterViewController
        case MasterViewControllerCell
        case DetailViewController
        case ColorMixViewController
        case StatisticsViewController
        case MaryHadALittleLambController
        case KingsmanIViewController
        case KingsmanIIViewController
        case StoryViewController
        case RandomViewController
        case gameViewController
        case ITViewController
        case LightViewController
        case LightController
        case Support
        case StudentsMode
        case UIColorß
        case AccountViewController
        case Account
        case PassedStudentsViewController
        case PassedStudentsCell
    }
    static var target:Target = .MenuViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "MenuViewController.swift":
            SourceTableViewController.target = .MenuViewController
        case "scoresView.swift":
            SourceTableViewController.target = .scoresView
        case "Score.swift":
            SourceTableViewController.target = .Score
        case "scoresViewCell.swift":
            SourceTableViewController.target = .scoresViewCell
        case "ChoosePassageController.swift":
            SourceTableViewController.target = .ChoosePassageController
        case "ScoreViewController.swift":
            SourceTableViewController.target = .ScoreViewController
        case "MasterViewController.swift":
            SourceTableViewController.target = .MasterViewController
        case "MasterViewControllerCell.swift":
            SourceTableViewController.target = .MasterViewControllerCell
        case "DetailViewController.swift":
            SourceTableViewController.target = .DetailViewController
        case "ColorMixViewController.swift":
            SourceTableViewController.target = .ColorMixViewController
        case "StatisticsViewController.swift":
            SourceTableViewController.target = .StatisticsViewController
        case "MaryHadALittleLambViewController.swift":
            SourceTableViewController.target = .MaryHadALittleLambController
        case "KingsmanIViewController.swift":
            SourceTableViewController.target = .KingsmanIViewController
        case "KingsmanIIViewController.swift":
            SourceTableViewController.target = .KingsmanIIViewController
        case "StoryViewController.swift":
             SourceTableViewController.target = .StoryViewController
            print("ha")
        case "RandomViewController.swift":
            SourceTableViewController.target = .RandomViewController
        case "gameViewComtroller.swift":
            SourceTableViewController.target = .gameViewController
        case "ITViewController.swift":
             SourceTableViewController.target = .ITViewController
        case "LightViewController.swift":
            SourceTableViewController.target = .LightViewController
        case "LightController.swift":
            SourceTableViewController.target = .LightController
        case "Support.swift":
            SourceTableViewController.target = .Support
        case "StudentsMode.swift":
            SourceTableViewController.target = .StudentsMode
        case "UIColorß.swift":
            SourceTableViewController.target = .UIColorß
        case "AccountViewController.swift":
            SourceTableViewController.target = .AccountViewController
        case "Account.swift":
            SourceTableViewController.target = .Account
        case "PassedStudentsViewController.swift":
            SourceTableViewController.target = .PassedStudentsViewController
        case "PassedStudentsCell.swift":
            SourceTableViewController.target = .PassedStudentsCell
        default:
            break
        }
    }
}

//All rights reserved.
