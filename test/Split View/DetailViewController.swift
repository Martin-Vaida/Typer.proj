//
//  DetailViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/14.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var colorMixView: UIStackView!
    @IBOutlet weak var colorMixImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var studentsModeNotification: UILabel!
    @IBOutlet weak var studentsModeBakcground: UIImageView!
    @IBOutlet weak var studentsModeLabel: UIButton!
    @IBOutlet weak var studentsModeSwitch: UISwitch!
    
    
    static var target:Target = .currentLabel
    
    enum Target {
        case currentLabel, currentLine, unusedLabel, unusedLine
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableTableView()
        toStatistics()
        
        studentsModeSwitch.isOn = MenuViewController.studentsMode
    }
    
    var enableColorMix = false {
        didSet {
            enableTableView()
        }
    }
    
    func enableTableView() {
        if let tabelViewß = colorMixView {
            tabelViewß.isHidden = !enableColorMix
        }
        if let colorMixImageViewß = colorMixImageView {
            colorMixImageViewß.isHidden = !enableColorMix
        }
        if let labelß = label {
            labelß.isHidden = !enableColorMix
        }
        if let label = studentsModeNotification {
            label.isHidden = !enableColorMix
            label.text = "Notice: This is a mode designed for students in NFLSXL."
        }
        if let bg = studentsModeBakcground {
            bg.isHidden = !enableColorMix
        }
        if let label = studentsModeLabel {
            label.isHidden = !enableColorMix
        }
        if let switchß = studentsModeSwitch {
            switchß.isHidden = !enableColorMix
        }
    }
    
    var toStatisticsBool:Bool = false {
        didSet {
            toStatistics()
        }
    }
    
    func toStatistics() {
        guard toStatisticsBool else { return }
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Statistics") as! StatisticsViewController
        viewController.navigationItem.title = "Statistics"
        self.navigationController!.pushViewController(viewController, animated: false)
    }
    
    @IBAction func studentsModeSwitch(_ sender: Any) {
        MenuViewController.studentsMode = studentsModeSwitch.isOn
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCurrentLabelColorMixView" {
            DetailViewController.target = .currentLabel
        } else if segue.identifier == "ToCurrentLineColorMixView" {
            DetailViewController.target = .currentLine
        } else if segue.identifier == "ToUnusedLabelColorMixView" {
            DetailViewController.target = .unusedLabel
        } else if segue.identifier == "ToUnusedLineColorMixView" {
            DetailViewController.target = .unusedLine
        }
        
    }
}
