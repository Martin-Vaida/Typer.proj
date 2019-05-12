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
    var correctLettersInAll = 0
    
    var labelArray:[UILabel] = []
    var lineArray:[UITextField] = []
    
    var correctLettersArray = [Int](repeatElement(0, count: 15))
    var tappedLettersArray = [Int](repeatElement(0, count: 15))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.navigationItem.title = "Mary Had A Little Lamb"
        
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
        labelOne.text = "Mary had a little lamb, little lamb, little lamb,"
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
        
        //Define labelArray
        labelArray.append(labelOne)
        labelArray.append(labelTwo)
        labelArray.append(labelThree)
        labelArray.append(labelFour)
        labelArray.append(labelFive)
        labelArray.append(labelSix)
        labelArray.append(labelSeven)
        labelArray.append(labelEight)
        labelArray.append(labelNine)
        labelArray.append(labelTen)
        labelArray.append(labelEleven)
        labelArray.append(labelTwelve)
        labelArray.append(labelThirteen)
        labelArray.append(labelFourteen)
        labelArray.append(labelFifteen)
        
        //Define lineArray
        lineArray.append(lineOne)
        lineArray.append(lineTow)
        lineArray.append(lineThree)
        lineArray.append(lineFour)
        lineArray.append(lineFive)
        lineArray.append(lineSix)
        lineArray.append(lineSeven)
        lineArray.append(lineEight)
        lineArray.append(lineNine)
        lineArray.append(lineTen)
        lineArray.append(lineEleven)
        lineArray.append(lineTwelve)
        lineArray.append(lineThirteen)
        lineArray.append(lineFourteen)
        lineArray.append(lineFifteen)
        
        //make colors of used labels gray
        for i in labelArray {
            i.textColor = .gray
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
            self.navigationItem.title = "Correct Letters: \(correctLettersInAll), Tapped Letters: \(tappedLetersInAll), Accuracy Rate: \(correctLettersInAll*100/tappedLetersInAll)%"
            self.accuracylabel.title = "Accuracy Rate"
        } else {
            self.accuracylabel.title = "Accuracy: \(correctLettersInAll*100/tappedLetersInAll)%"
        }
    }
    
    //viewcontrollers
    
    @IBAction func lineOneBegin(_ sender: Any) {
        startTimer()
        
        labelOne.textColor = .darkGray
    }
    
    //When User changed Valve...
    func updateValue(line:Int) {
        
        if lineArray[line-1].text?.count == labelArray[line-1].text!.count+1 {
            guard line != 15 else {
                stopTimer()
                return
            }
            
            lineArray[line-1].resignFirstResponder()
            lineArray[line].text = " "
            lineArray[line].becomeFirstResponder()
            
            labelArray[line-1].textColor = .gray
            labelArray[line].textColor = .darkGray
            
            lineArray[line-1].textColor = .gray
            lineArray[line].textColor = .black
        }
        
        guard lineArray[line-1].text != nil else { return }
        
        if lineArray[line-1].text!.count == 0 {
            if line == 1 {
                lineArray[line-1].text = " "
            } else {
                lineArray[line-1].resignFirstResponder()
                lineArray[line-2].becomeFirstResponder()
                
                labelArray[line-1].textColor = .gray
                labelArray[line-2].textColor = .darkGray
                
                lineArray[line-1].textColor = .gray
                lineArray[line-2].textColor = .black
            }
        }
        
        guard labelArray[line-1].text != nil else { return }
        guard lineArray[line-1].text!.count >= 2 else { return }
        tappedLetersInAll = lineArray[line-1].text!.count
        
        var tempCorrectLetterCount = 0
        tempCorrectLetterCount = 0
        
        for i in 1...lineArray[line-1].text!.count-1 {
            let inputLetter = lineArray[line-1].text![lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i)]
            let origenalLetter = labelArray[line-1].text![labelArray[line-1].text!.index(labelArray[line-1].text!.startIndex, offsetBy: i-1)]
            
            if inputLetter == origenalLetter {
                tempCorrectLetterCount += 1
            } else {
                lineArray[line-1].text!.remove(at: lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i))
                lineArray[line-1].text!.insert("_", at: lineArray[line-1].text!.index(lineArray[line-1].text!.startIndex, offsetBy: i))
            }
        }
        
        correctLettersArray[line-1] = tempCorrectLetterCount
        tappedLettersArray[line-1] = lineArray[line-1].text!.count - 1
        
        correctLettersInAll = 0
        for i in correctLettersArray {
            correctLettersInAll += i
        }
        
        tappedLetersInAll = 0
        for i in tappedLettersArray {
            tappedLetersInAll += i
        }
        
        updateAccuracyLabel()
    }
    
    //User is editing lineOne
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
    
    @IBAction func lineElevenChanged(_ sender: Any) {
        updateValue(line: 11)
    }
    
    @IBAction func lineTwelveChanged(_ sender: Any) {
        updateValue(line: 12)
    }
    
    @IBAction func lineThirteenChanged(_ sender: Any) {
        updateValue(line: 13)
    }
    
    @IBAction func lineFourteenChanged(_ sender: Any) {
        updateValue(line:14)
    }
    
    @IBAction func lineFifteenChanged(_ sender: Any) {
        updateValue(line: 15)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        stopTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "ResultsSegue" else { return }
        
        let correctLetters = correctLettersInAll
        let tappedLetters = tappedLetersInAll
        
        ScoreViewController.score = Score(correctLetters, tappedLetters, timePassed, false, .maryHadALittleLamb)
    }
}
