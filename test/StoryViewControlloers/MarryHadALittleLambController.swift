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
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var lineOneTappedLeters = 0
    
    var correctLettersInAll = 0
    var lineOneCorrectLetters = 0
    
    let accuracy = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationItem.title = "Mary Had A Little Lamb"
        
        //cancel auto correcting
        lineOne.autocorrectionType = .no
        lineTow.autocorrectionType = .no
        lineThree.autocorrectionType = .no
        lineFour.autocorrectionType = .no
        lineFive.autocorrectionType = .no
        lineSix.autocorrectionType = .no
        lineSeven.autocorrectionType = .no
        lineEight.autocorrectionType = .no
        lineNine.autocorrectionType = .no
        lineTen.autocorrectionType = .no
        lineEleven.autocorrectionType = .no
        lineTwelve.autocorrectionType = .no
        lineThirteen.autocorrectionType = .no
        lineFourteen.autocorrectionType = .no
        lineFifteen.autocorrectionType = .no
    }
    
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    @IBOutlet weak var labelSix: UILabel!
    @IBOutlet weak var labelSeven: UILabel!
    @IBOutlet weak var labelEight: UILabel!
    @IBOutlet weak var labelNine: UILabel!
    @IBOutlet weak var labelTen: UILabel!
    @IBOutlet weak var labelEleven: UILabel!
    @IBOutlet weak var labelTwelve: UILabel!
    @IBOutlet weak var labelThirteen: UILabel!
    @IBOutlet weak var labelFourteen: UILabel!
    @IBOutlet weak var labelFifteen: UILabel!
    
    @IBOutlet weak var lineOne: UITextField!
    @IBOutlet weak var lineTow: UITextField!
    @IBOutlet weak var lineThree: UITextField!
    @IBOutlet weak var lineFour: UITextField!
    @IBOutlet weak var lineFive: UITextField!
    @IBOutlet weak var lineSix: UITextField!
    @IBOutlet weak var lineSeven: UITextField!
    @IBOutlet weak var lineEight: UITextField!
    @IBOutlet weak var lineNine: UITextField!
    @IBOutlet weak var lineTen: UITextField!
    @IBOutlet weak var lineEleven: UITextField!
    @IBOutlet weak var lineTwelve: UITextField!
    @IBOutlet weak var lineThirteen: UITextField!
    @IBOutlet weak var lineFourteen: UITextField!
    @IBOutlet weak var lineFifteen: UITextField!
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    
    //define texts
    func setup() {
        labelOne.text = "Mary had a little lamb, little lamb, little lamb,"
        labelTwo.text = "Mary had a little lamb, its fleece was white as snow."
        labelThree.text = "And everywhere that Mary went, Mary went, Mary went,"
        labelFour.text = "And everywhere that Mary went, the lamb was sure to go."
        labelFive.text = "It followed her to school one day, school one day, school one day,"
        labelSix.text = "It followed her to school one day, which was against the rules."
        labelSeven.text = "It made the children laugh and play, laugh and play, laugh and play,"
        labelEight.text = "It made the children laugh and play to see a lamb at school."
        labelNine.text = "And so the teacher turned it out, turned it out, turned it out,"
        labelTen.text = "And so the teacher turned it out, but still it lingered near, And waited patiently about"
        labelEleven.text = "And waited patiently about till Mary did appear."
        labelTwelve.text = "Why does the lamb love Mary so? Love Mary so? Love Mary so?"
        labelThirteen.text = "Why does the lamb love Mary so, the eager children cry."
        labelFourteen.text = "Why, Mary loves the lamb, you know. The lamb, you know, the lamb, you know"
        labelFifteen.text = "Why, Mary loves the lamb, you know, the teacher did reply."
        
        lineOne.text = " "
    }
    
    
    //Timer
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            self.timeCounter += 0.1
            guard self.timer != nil else { return }
            
            let str = String(self.timeCounter)
            var array:[String] = []
            self.timePassed = ""
            
            for i in str {
                array.append(String(i))
            }
            
            for i in 0...array.count-1 {
                self.timePassed += array[i]
                
                if array[i] == "." {
                    self.timePassed += array[i+1]
                    break
                }
            }
            
            self.timeLabel.title = "Time: \(String(self.timePassed))"
            
            if self.timeTappedBool {
                self.navigationItem.title = self.timeLabel.title
                self.timeLabel.title = "Time"
            }
            if !self.timeTappedBool && !self.accuracyTappedBool {
                self.navigationItem.title = "Mary Had A Little Lamb"
            }
        })
    }
    
    func stopTimer() {
        if timer != nil {
            timer!.invalidate() //销毁timer
            timer = nil
        }
    }
    
    
    
    func updateAccuracyLabel() {
        if accuracyTappedBool {
            self.navigationItem.title = "Correct Letters: \(correctLettersInAll), Tapped Letters: \(tappedLetersInAll), Accuracy Rate: \(correctLettersInAll*accuracy/tappedLetersInAll)%"
            self.accuracylabel.title = "Accuracy Rate"
        } else {
            self.accuracylabel.title = "Accuracy: \(correctLettersInAll*accuracy/tappedLetersInAll)%"
        }
    }
    
    //viewcontrollers
    
    @IBAction func lineOneBegin(_ sender: Any) {
        startTimer()
    }
    
    @IBAction func lineOneChanged(_ sender: Any) {
        if lineOne.text?.count == labelOne.text!.count+1 {
            lineOne.resignFirstResponder()
            lineTow.text = " "
            lineTow.becomeFirstResponder()
        }
        
        guard lineOne.text != nil else { return }
        
        if lineOne.text!.count == 0 {
            lineOne.text = " "
        }
        
        guard labelOne.text != nil else { return }
        guard lineOne.text!.count >= 2 else { return }
        tappedLetersInAll = lineOne.text!.count
        
        var tempCorrectLetterCount = 0
        tempCorrectLetterCount = 0
        
        for i in 1...lineOne!.text!.count-1 {
            let inputLetter = lineOne!.text![lineOne!.text!.index(lineOne!.text!.startIndex, offsetBy: i)]
            let origenalLetter = labelOne!.text![labelOne!.text!.index(labelOne!.text!.startIndex, offsetBy: i-1)]
            
            if inputLetter == origenalLetter {
                tempCorrectLetterCount += 1
            } else {
                lineOne!.text!.remove(at: lineOne!.text!.index(lineOne!.text!.startIndex, offsetBy: i))
                lineOne!.text!.insert("_", at: lineOne!.text!.index(lineOne!.text!.startIndex, offsetBy: i))
            }
        }
        
        lineOneCorrectLetters = tempCorrectLetterCount
        lineOneTappedLeters = lineOne!.text!.count - 1
        
        correctLettersInAll = lineOneCorrectLetters
        tappedLetersInAll = lineOneTappedLeters
        
        updateAccuracyLabel()
        
    }
    
    @IBAction func lineTwoChaged(_ sender: Any) {
        if lineTow.text?.count == labelTwo.text!.count+1 {
            lineTow.resignFirstResponder()
            lineThree.text = " "
            lineThree.becomeFirstResponder()
        }
        
        if lineTow.text?.count == 0 {
            lineTow.resignFirstResponder()
            lineOne.becomeFirstResponder()
        }
    }
    
    @IBAction func lineThreeChanged(_ sender: Any) {
        if lineThree.text?.count == labelThree.text!.count+1 {
            lineThree.resignFirstResponder()
            lineFour.text = " "
            lineFour.becomeFirstResponder()
        }
        
        if lineThree.text?.count == 0 {
            lineThree.resignFirstResponder()
            lineTow.becomeFirstResponder()
        }
    }
    
    
    //Navigation Item
    
    @IBAction func timetapped(_ sender: Any) {
        guard timeLabel.title != nil else { return }
        timeTappedBool = !timeTappedBool
    }
    
    @IBAction func accuracyTapped(_ sender: Any) {
        guard accuracylabel.title != nil else { return }
        accuracyTappedBool = !accuracyTappedBool
        updateAccuracyLabel()
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ResultsSegue" else { return }
        
        let correctLetters = correctLettersInAll
        let tappedLetters = tappedLetersInAll
        
        ScoreViewController.score = Score(correctLetters, tappedLetters, timePassed)
    }
}
