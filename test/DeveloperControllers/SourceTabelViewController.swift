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
        default:
            break
        }
    }
}

//All rights reserved.
