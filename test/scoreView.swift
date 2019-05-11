//
//  ScoreView.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/11.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class ScoreViewController:UITableViewController {
    static var score:Score?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScore()
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var accuracyLabelOne: UILabel!
    @IBOutlet weak var accuracyLabelTwo: UILabel!
    @IBOutlet weak var takenTimeLabel: UILabel!
    
    func updateScore() {
        guard ScoreViewController.score?.timeDescription() != nil,
            ScoreViewController.score?.accuracyRateDescreption() != nil,
            ScoreViewController.score?.accuracyDescription() != nil,
            ScoreViewController.score?.dateDescription() != nil else {
                defaultScore()
                return
        }
        
        timeLabel.text = ScoreViewController.score!.timeDescription()
        accuracyLabelOne.text = ScoreViewController.score!.accuracyRateDescreption()
        accuracyLabelTwo.text = ScoreViewController.score!.accuracyDescription()
        takenTimeLabel.text = ScoreViewController.score!.dateDescription()
        
        scoresView.scoreCollection.append(ScoreViewController.score!)
    }
    
    func defaultScore() {
        timeLabel.text = "nil"
        accuracyLabelOne.text = "nil"
        accuracyLabelTwo.text = "nil"
        takenTimeLabel.text = "nil"
    }
}

