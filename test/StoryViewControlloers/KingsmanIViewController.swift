//
//  KingsmanViewController.swift
//  Typer.proj
//
//  Created by Vaida on 2019/5/22.
//  Copyright © 2019 Martin_Vaida. All rights reserved.
//

import Foundation
import UIKit

class KingsmanIViewController:UITableViewController {
    var lineCount = 0
    
    @IBOutlet var labelArray: [UILabel]!
    @IBOutlet var lineArray: [UITextField]!
    
    var labelArrayß:[UILabel] = []
    var lineArrayß:[UITextField] = []
    
    @IBOutlet weak var timeLabel: UIBarButtonItem!
    @IBOutlet weak var accuracylabel: UIBarButtonItem!
    
    var currentLabelColor:UIColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
    var currentLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    var unusedLabelColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    var unusedLineColor:UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    
    var timer:Timer?
    var timeCounter = 0.0
    var timePassed = ""
    
    var timeTappedBool = false
    var accuracyTappedBool = false
    
    var tappedLetersInAll = -1
    var correctLettersInAll = 0
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    var tempCorrectLetters = [Character]()
    var tempTappedLetter = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationItem.title = "Kingsman Collection I"
        
        currentLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[0].red)!), green: CGFloat(Double(colorMixViewController.colorArray[0].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[0].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[0].alpha)!))
        currentLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[1].red)!), green: CGFloat(Double(colorMixViewController.colorArray[1].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[1].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[1].alpha)!))
        unusedLabelColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[2].red)!), green: CGFloat(Double(colorMixViewController.colorArray[2].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[2].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[2].alpha)!))
        unusedLineColor = UIColor(red: CGFloat(Double(colorMixViewController.colorArray[3].red)!), green: CGFloat(Double(colorMixViewController.colorArray[3].green)!), blue: CGFloat(Double(colorMixViewController.colorArray[3].blue)!), alpha: CGFloat(Double(colorMixViewController.colorArray[3].alpha)!))
    }
    
    func setup() {
        for i in labelArray {
            labelArrayß.append(i)
        }
        for i in lineArray {
            lineArrayß.append(i)
        }
        
        for i in lineArrayß {
            i.autocorrectionType = .no
            i.placeholder = ""
        }
        
        for i in labelArrayß {
            i.textColor = unusedLabelColor
            i.text = ""
        }
        
        labelArrayß[0].text = "Front page news,"
        labelArrayß[1].text = "and all the occasions were celebrity nonsense,"
        labelArrayß[2].text = "because it’s the nature of kingsmen,"
        labelArrayß[3].text = "that our achievements remain secret."
        labelArrayß[4].text = "A gentleman’s name should appear in the newspaper only three times:"
        labelArrayß[5].text = "when he’s born,"
        labelArrayß[6].text = "when he marries and when he dies."
        labelArrayß[7].text = "And we are,"
        labelArrayß[8].text = "first and foremost,"
        labelArrayß[9].text = "gentleman."
        lineCount = 10
        
        lineArrayß[0].text = " "
        
        var i = -1
        for int in 0...labelArrayß.count-1 {
            i += 1
            if labelArrayß[i].text! == "" {
                labelArrayß.remove(at: i)
                lineArrayß.remove(at: i)
                i -= 1
                
                labelArray[int].isHidden = true
                lineArray[int].isHidden = true
            }
        }
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
                self.navigationItem.title = "Kingsman Collection I"
            }
            
            if MenuViewController.forceQuite {
                if self.timeCounter >= 60.0 {
                    let correctLetters = self.correctLettersInAll
                    let tappedLetters = self.tappedLetersInAll
                    
                    ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection I","", MenuViewController.userName)
                    
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
                    self.navigationController!.pushViewController(viewController, animated: true)
                }
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
            self.navigationItem.title = "Correct Letters: \(correctLettersInAll), Tapped Letters: \(tappedLetersInAll), Accuracy Rate: \(correctLettersInAll*100/tappedLetersInAll)%"
            self.accuracylabel.title = "Accuracy Rate"
        } else {
            self.accuracylabel.title = "Accuracy: \(correctLettersInAll*100/tappedLetersInAll)%"
        }
    }
    
    
    @IBAction func LineOneBegin(_ sender: Any) {
        startTimer()
        
        labelArrayß[0].textColor = currentLabelColor
        lineArrayß[0].textColor = currentLineColor
    }
    
    
    var tempCorrectLetterCount = 0
    
    //When User changed Valve...
    func updateValue(line:Int) {
        
        guard lineArrayß[line-1].text != nil else { return }
        guard lineArray[line-1].text!.count < labelArray[line-1].text!.count+2 else { return }
        
        if lineArrayß[line-1].text!.count == 0 {
            if line == 1 {
                lineArrayß[line-1].text = " "
            } else {
                lineArrayß[line-1].resignFirstResponder()
                lineArrayß[line-2].becomeFirstResponder()
                
                labelArrayß[line-1].textColor = unusedLabelColor
                labelArrayß[line-2].textColor = currentLabelColor
                
                lineArrayß[line-1].textColor = unusedLineColor
                lineArrayß[line-2].textColor = currentLineColor
                
                tempCorrectLetters = []
                tempTappedLetter = []
                tempCorrectLetterCount = 0
                
                for i in lineArrayß[line-2].text! {
                    tempTappedLetter.append(i)
                }
                for i in labelArrayß[line-2].text! {
                    tempCorrectLetters.append(i)
                }
                for i in 0...tempTappedLetter.count-2 {
                    if tempCorrectLetters[i] == tempTappedLetter[i+1] {
                        tempCorrectLetterCount += 1
                    }
                }
            }
        }
        
        guard labelArrayß[line-1].text != nil else { return }
        guard lineArrayß[line-1].text!.count >= 2 else { return }
        tappedLetersInAll = lineArrayß[line-1].text!.count
        
        
        
        if lineArrayß[line-1].text!.count > tempCorrectLetters.count {
            tempCorrectLetters.append(labelArrayß[line-1].text![(labelArrayß[line-1].text?.index(labelArrayß[line-1].text!.startIndex, offsetBy: tempCorrectLetters.count))!])
            tempTappedLetter.append(lineArrayß[line-1].text![lineArrayß[line-1].text!.index(before: lineArrayß[line-1].text!.endIndex)])
            
            if tempTappedLetter[tempTappedLetter.count-1] == tempCorrectLetters[tempCorrectLetters.count-1] {
                tempCorrectLetterCount += 1
            } else {
                lineArrayß[line-1].text!.removeLast()
                lineArrayß[line-1].text!.append("_")
            }
            
        } else {
            if tempCorrectLetters[tempCorrectLetters.count-1] == tempTappedLetter[tempTappedLetter.count-1] {
                tempCorrectLetterCount -= 1
            }
            
            tempCorrectLetters.remove(at: tempCorrectLetters.count-1)
            tempTappedLetter.remove(at: tempTappedLetter.count-1)
        }
        
        correctLettersArray[line-1] = tempCorrectLetterCount
        tappedLettersArray[line-1] = lineArrayß[line-1].text!.count - 1
        
        correctLettersInAll = 0
        for i in correctLettersArray {
            correctLettersInAll += i
        }
        
        tappedLetersInAll = 0
        for i in tappedLettersArray {
            tappedLetersInAll += i
        }
        
        updateAccuracyLabel()
        
        if lineArrayß[line-1].text!.count == labelArrayß[line-1].text!.count+1 {
            guard line != lineCount else {
                stopTimer()
                let correctLetters = self.correctLettersInAll
                let tappedLetters = self.tappedLetersInAll
                
                ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), self.timePassed, false, "Kingsman Collection I", "", MenuViewController.userName)
                
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Score_View_Single") as! ScoreViewController
                self.navigationController!.pushViewController(viewController, animated: true)
                
                return
            }
            
            lineArrayß[line-1].resignFirstResponder()
            lineArrayß[line].text = " "
            lineArrayß[line].becomeFirstResponder()
            
            labelArrayß[line-1].textColor = unusedLabelColor
            labelArrayß[line].textColor = currentLabelColor
            
            lineArrayß[line-1].textColor = unusedLineColor
            lineArrayß[line].textColor = currentLineColor
            tempCorrectLetters = []
            tempTappedLetter = []
            tempCorrectLetterCount = 0
            return
        }
    }
    
    @IBAction func lineOneChanged(_ sender: Any) {
        updateValue(line: 1)
    }
    
    @IBAction func lineTwoChaged(_ sender: Any) {
        updateValue(line: 2)
    }
    
    @IBAction func lineThreeChanged(_ sender: Any) {
        updateValue(line: 3)
    }
    
    @IBAction func lineFourChanged(_ sender: Any) {
        updateValue(line: 4)
    }
    
    @IBAction func lineFiveChanged(_ sender: Any) {
        updateValue(line: 5)
    }
    
    @IBAction func lineSixChanged(_ sender: Any) {
        updateValue(line: 6)
    }
    
    @IBAction func lineSevenChanged(_ sender: Any) {
        updateValue(line: 7)
    }
    
    @IBAction func lineEightChanged(_ sender: Any) {
        updateValue(line: 8)
    }
    
    @IBAction func lineNineChanged(_ sender: Any) {
        updateValue(line: 9)
    }
    
    @IBAction func lineTenChanged(_ sender: Any) {
        updateValue(line: 10)
    }
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ResultsSegue" else { return }
        
        let correctLetters = correctLettersInAll
        let tappedLetters = tappedLetersInAll
        
        ScoreViewController.score = Score(String(correctLetters), String(tappedLetters), timePassed, false, "Kingsman Collection I", "", MenuViewController.userName)
    }
    
    
}
